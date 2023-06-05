<?php
     $con = mysqli_connect("localhost","id20699314_myapiapp","LathiyaDevik@1783","id20699314_api_demo") or die("DB Not Connect");

     $qry = "select * from Api_contact";
     $data = mysqli_query($con,$qry);

     $result = array();
     $row = array();

     if($data)
     {
        $result['status'] = 'Done';
        while($rw = mysqli_fetch_assoc($data))
        {
            $row[]=$rw;
        }

        $result['Data'] = $row;
     }
     else
     {
        $result['status'] = 'Not Found';
     }
     echo json_encode($result);

?>