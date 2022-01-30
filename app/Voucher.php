<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Voucher extends Model
{
    protected $table = "voucher";
    protected $primaryKey="id_voucher";
    protected $guarded=[];
}
