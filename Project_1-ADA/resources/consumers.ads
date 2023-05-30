package consumers is
   nConsumerTypes: constant Integer := 2;
   
   subtype consumerType is Integer range 1 .. nConsumerTypes;
   
   consumerName: constant array (consumerType) of String(1 .. 9)
     := ("Passerby ", 
         "HouseWife");
end consumers;
