<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Purchase_transaction extends Model
{
    protected $table = "purchase_transaction";
    protected $primaryKey="id";
    protected $guarded=[];
}
