package products is
   nProductTypes: constant Integer := 5;
   subtype productType is Integer range 1 .. nProductTypes;
   
   productName: constant array (productType) of String(1 .. 10)
     := ("Plant     ", 
         "Pot       ",
         "Seeds     ", 
         "Soil      ",
         "Fertilizer");        
end products;
