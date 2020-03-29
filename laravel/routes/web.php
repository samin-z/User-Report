<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/', 'HomeController@index')->name('index');

Route::post('/user/submit', 'UserController@store')->name('user_form_store');
Route::get('/report/{id}', 'ReportController@show')->name('report_form');
Route::post('/report/store/{id}', 'ReportController@store')->name('report_form_store');

///cp panel
Route::get('/cp', 'PanelController@index')->name('cp_index');
Route::get('/cp/report/{id}', 'PanelController@view')->name('cp_report_view');
Route::get('/cp/pdf/{id}', 'PanelController@download')->name('cp_report_download');

//
Auth::routes();

