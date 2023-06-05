<?php
    if(isset($_POST['from']))
    {
        $from = $_POST['from'];
    }
    else return;

    if(isset($_POST['to']))
    {
        $to = $_POST['to'];
    }
    else return;

    if(isset($_POST['amount']))
    {
       $amount = $_POST['amount'];
    }
    else return;

    $curl = curl_init();

    curl_setopt_array($curl, array(
      CURLOPT_URL => "https://api.apilayer.com/exchangerates_data/convert?to=$to&from=$from&amount=$amount",
      CURLOPT_HTTPHEADER => array(
        "Content-Type: text/plain",
        "apikey: qRiyCPiSGMjaQGmYOLG5ci5fRPv644am"
      ),
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => "",
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 0,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => "GET"
    ));

    $response = curl_exec($curl);

    curl_close($curl);
    echo $response;


?>

