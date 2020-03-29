<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportTasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('report_tasks', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('report_id');
            $table->foreign('report_id')->references('id')->on('reports')->onDelete('cascade');
            $table->text('task');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('report_tasks');
    }
}
