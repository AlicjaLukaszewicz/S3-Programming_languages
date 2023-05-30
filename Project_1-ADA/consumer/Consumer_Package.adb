with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

with assemblies;
with Buffer_Package;

package body Consumer_Package is

   task body Consumer is
      subtype consumingTimeRange is Integer range 5 .. 9;
      subtype assembliesTypeRange is Integer range 1 .. assemblies.nAssemblyTypes;
      
      package ChooseConsumingTime is new
        Ada.Numerics.Discrete_Random(consumingTimeRange);
      timeSeed: ChooseConsumingTime.Generator;
      
      package ChooseAssemblyType is new
        Ada.Numerics.Discrete_Random(assembliesTypeRange);
      assemblySeed: ChooseAssemblyType.Generator;
        
      consumerTypeNumber: Integer;
      assemblyType: Integer;
      consumingTime: Duration; 
      boughtAssembly: Boolean;
   begin
      accept StartConsuming(Consumer: in consumers.consumerType) do
         consumerTypeNumber := Consumer;
      end StartConsuming;
      
      loop
         ChooseConsumingTime.Reset(timeSeed);
         consumingTime := Duration(ChooseConsumingTime.Random(timeSeed));
         
         ChooseAssemblyType.Reset(assemblySeed);
         assemblyType := ChooseAssemblyType.Random(assemblySeed);
         
         Put_Line("Entered store: " & consumers.consumerName(consumerTypeNumber));
         
         Put_Line("Started buying products for assembly: " &
                    assemblies.assemblyName(assemblyType));
         
         delay consumingTime;
         
         Buffer_Package.B.DeliverAssemblyToCustomer(assemblyType, boughtAssembly);
         
         if boughtAssembly = True then
            Put_Line(consumers.consumerName(consumerTypeNumber) & ": taken assembly " &
                       assemblies.assemblyName(assemblyType));
         else 
            Put_Line(consumers.consumerName(consumerTypeNumber) & " couldn't buy assembly: " & assemblies.assemblyName(assemblyType));
         end if;
      end loop;
   end Consumer;
end Consumer_Package;
