with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Characters.Latin_1;

with Buffer_Package;

package body Producer_Package is
   task body Producer is
      subtype productionTimeRange is Integer range 3 .. 6;
      
      package ChooseProductionTime is new
        Ada.Numerics.Discrete_Random(productionTimeRange);
      seed: ChooseProductionTime.Generator;
        
      productTypeNumber: Integer;
      productNumber: Integer;
      productionTime: Duration;
      
   begin
      accept StartProducing(Product: in products.productType) do
         productNumber := 1;
         productTypeNumber := Product;
      end StartProducing;
      
      loop
         ChooseProductionTime.Reset(seed);
         productionTime := Duration(ChooseProductionTime.Random(seed));
         
         
         if Buffer_Package.storage(productTypeNumber) <= 2 then
            Put_Line("There is not enough products for type: " & products.productName(productTypeNumber));
            Put_Line("Producer is bound to work harder for its completion. Production time decreases.");
            productionTime := productionTime - 3.0;
         end if;
         
         
         Put_Line("Started production of " &
                    products.productName(productTypeNumber));
         
         delay productionTime;
         
         Put_Line("Produced:" & Ada.Characters.Latin_1.LF &
                    "   Number " & Integer'Image(productNumber) & " " &
                    products.productName(productTypeNumber) & Ada.Characters.Latin_1.LF &
                    "   Time:  " & Duration'Image(productionTime));
         
         Buffer_Package.B.TakeProductToStorage(productTypeNumber);  
         productNumber := productNumber + 1;
      end loop;
   end Producer;
end Producer_Package;
