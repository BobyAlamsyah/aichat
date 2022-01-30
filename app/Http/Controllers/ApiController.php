<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Voucher;
class ApiController extends Controller
{
    // function api to check customer eligible
    public function eligible_check(Request $request){
        //reset voucher if not submit in 10 minutes
        $this->reset_voucher();

        $post = $request->all();

        //get auth token
        $auth_token=DB::select('select token from token_api');
       
        //check auth token
        if(isset($post['token']) && $post['token']==$auth_token[0]->token){
            //check if customer complete 3 purchase
            $purchase_count=DB::table('purchase_transaction')
                ->select(DB::raw('count(*) as purchase_count'))
                ->where('customer_id', $post['customer_id'])
                ->count();

            //check total transaction customer >= $100
            $total_transaction=DB::table('purchase_transaction')
                ->select(DB::raw('sum(total_spent) as total_transaction'))
                ->where('customer_id', $post['customer_id'])
                ->get();

            //check customer ever redeem voucher or not
            $redeem_voucher=DB::table('voucher')
                ->select(DB::raw('count(*) as redeem_voucher'))
                ->where('is_redeem', 1)
                ->where('get_by_customer_id', $post['customer_id'])
                ->count();

            //check if customer eligible to get voucher
            if($purchase_count >= 3 && $total_transaction[0]->total_transaction >= 100 && $redeem_voucher == 0){

                //lockdown voucher
                $voucher_code=Voucher::where([['is_redeem','=',0],['is_locked','=',0]])->first();
                if(!empty($voucher_code)){
                    $voucher_code->is_locked=1;
                    $voucher_code->get_by_customer_id=$post['customer_id'];
                    $voucher_code->is_locked_timestamp=date('Y-m-d H:i:s');
                    $voucher_code->save();
                } else {
                    $response = array(
                        'status' => 'Voucher Empty',
                        'message' => 'All Voucher Has Been Redeem'
                    );
                    return response()->json($response,200);
                }
                $response = array(
                    'status' => 'eligible',
                    'message' => 'Customer eligible to get voucher'
                );

            }else{
                $response = array(
                    'status' => 'not eligible',
                    'message' => 'Customer not eligible to get voucher'
                );
            }
                return response()->json($response,200);

        } else{
            return response()->json([
                'message' => "Invalid Token" 
            ], 200);
        }

    }

    //validate photo submisson
    public function validate_photo(Request $request){
        $post = $request->all();

        //get auth token
        $auth_token=DB::select('select token from token_api');

        //check auth token
        if(isset($post['token']) && $post['token']==$auth_token[0]->token){

            //get customer voucher and get time when voucher locked
            $voucher=Voucher::where([['is_redeem','=',0],['is_locked','=',1],['get_by_customer_id','=',$post['customer_id']]])->first();
            $lock_time=strtotime($voucher->is_locked_timestamp);
            $current_time=strtotime(date('Y-m-d H:i:s'));
            $diff_time=$current_time-$lock_time;

            //validate
            if($this->recognize_photo()=="TRUE" && $diff_time <= 600){
                $voucher->is_redeem=1;
                $voucher->save();

                return response()->json([
                    'status' => "Voucher Redeem Successfully",
                    'message' => "Voucher Redeem Successfully",
                    'voucher_code' => $voucher->voucher_code  
                ], 200);
            } else {
                $this->reset_voucher();
                return response()->json([
                    'status' => "Voucher Redeem Failed",
                    'message' => "Your Photo Not Valid Or Timeout",
                    'voucher_code' => ""  
                ], 200);
            }
            
        } else {
            return response()->json([
                'message' => "Invalid Token" 
            ], 200);
        }
        
    }

    //Fake Api to recognize photo
    public function recognize_photo(){
        $input = array("TRUE", "FALSE");
        shuffle($input);
        return $input[0];
    }
    

    //reset voucher lock if more than 10 minutes
    public function reset_voucher(){
        $voucher_code=Voucher::where([['is_redeem','=',0],['is_locked','=',1]])->get();
        foreach($voucher_code as $voucher){
            $lock_time=strtotime($voucher->is_locked_timestamp);
            $current_time=strtotime(date('Y-m-d H:i:s'));
            $diff_time=$current_time-$lock_time;
            if($diff_time >= 600){
                $voucher->is_locked=0;
                $voucher->get_by_customer_id=null;
                $voucher->is_locked_timestamp=null;
                $voucher->is_redeem=0;
                $voucher->save();
            }
        }
    }
}
