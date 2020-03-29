<?php

namespace App\Http\Controllers;

use App\Report;
use Elibyy\TCPDF\Facades\TCPDF;
//use PDF;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PanelController extends Controller
{
    //
    public function __construct()
    {
        $this->middleware('auth');
    }

    private function Browse($request)
    {

        $que = Report::orderBy('id','DESC');

        if($request->input('date_start'))
            $que->whereDate('created_at' , '>=' ,  $request->input('date_start') ) ;
        
        if($request->input('date_end'))
            $que->whereDate('created_at' , '<=' ,  $request->input('date_end') ) ;
        
        return $que;
    }

    function index(Request $request)
    {
        if(!Auth::user()->is_admin)
            abort(403);

        $que = $this->Browse($request);

        // "paginate" is used for reading bulk records from database which helps with pagination
        $reports = $que->paginate(15);
        return view('cp-index',['user'=>Auth::user(),'reports'=>$reports]);
    }

    function view($id)
    {
        $report = Report::findOrFail($id);
        return view('report-view',['report'=>$report]);
    }

    function download($id)
    {
        //// using "findOrFail" if no matching model exist, it throws an error
        $report = Report::findOrFail($id);
        $this->download_pdf($report);
//        return view('report-pdf-form',['report',$report]);
    }

    private function download_pdf ($report)
    {
        $html = view('report-pdf-form' ,['report'=>$report]);
        $pdf = new \Elibyy\TCPDF\TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);


// set margins
        $pdf->SetMargins(15,15);
        $pdf->SetHeaderMargin(0);
        $pdf->SetFooterMargin(0);


        $pdf->AddPage('P','A3');

// set some language dependent data:
        $lg = Array();
        $lg['a_meta_charset'] = 'UTF-8';
        $lg['a_meta_dir'] = 'rtl';
        $lg['a_meta_language'] = 'fa';
        $lg['w_page'] = 'page';

// set some language-dependent strings (optional)
        $pdf->setLanguageArray($lg);

// ---------------------------------------------------------

// set font
        $pdf->SetFont('dejavusans', '', 12);
//        $pdf->addTTFfont(asset('asset/fonts/BNazanin.ttf'), 'TrueTypeUnicode', '', 32);
//        $pdf->SetFont('nazaninb', '', 12,'',FALSE);

// add a page
//        $pdf->AddPage();

// Persian and English content
        $pdf->WriteHTML($html->render(), true, 0, true, 0);

// set LTR direction for english translation

        $pdf->SetFontSize(8);

// print newline
        $pdf->Ln();

// Persian and English content

// Restore RTL direction
        $pdf->setRTL(true);

// set font

// ---------------------------------------------------------

//Close and output PDF document
        $pdf->Output('report'.$report->id.'.pdf', 'I');
    }


}
