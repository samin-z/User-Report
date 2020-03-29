<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('reports', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->text('current_week');
            $table->text('next_week');
            $table->date('next_week_date');
            $table->timestamps();
        });
        
        //trigger is an object of database, every time a new record(report) is inserted by a user, "report_cound"
//        in "users" database is added by one.
        DB::unprepared('CREATE TRIGGER new_report
        AFTER INSERT ON reports FOR EACH ROW
        BEGIN
            UPDATE users SET report_count = report_count + 1 WHERE id = NEW.user_id;
        END
        ');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reports');
    }
}
