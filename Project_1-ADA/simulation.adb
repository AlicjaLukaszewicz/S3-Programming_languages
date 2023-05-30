with Ada.Text_IO; use Ada.Text_IO;

with Producer_Package;
with Consumer_Package;

with products;
with consumers;

procedure Simulation is
   P: array (1 .. products.nProductTypes) of Producer_Package.Producer;
   C: array (1 .. consumers.nConsumerTypes) of Consumer_Package.Consumer;
begin
   Put_Line("## Start of the simlutation ##");
   Put_Line("");


   for I in 1 .. products.nProductTypes loop
      P(I).StartProducing(I);
   end loop;
   for I in 1 .. consumers.nConsumerTypes loop
      C(I).StartConsuming(I);
   end loop;

end Simulation;
