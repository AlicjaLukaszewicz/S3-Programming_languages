with Ada.Text_IO; use Ada.Text_IO;
with functions;

package body Buffer_Package is
   Day: Integer := 0;
   
   task body Buffer is  
   begin 
      loop 
         select
            accept TakeProductToStorage(product: in products.productType) do
               if functions.CanAcceptProductIntoStorage(product) = True then
                  Put_Line("  > Accepted product " & products.productName(Product));
                  
                  storage(product) := storage(Product) + 1;
                  productsInStorage := productsInStorage + 1;
               else
                  Put_Line("  > Rejected product " & products.productName(product));
               end if;
            end TakeProductToStorage;
         or
            accept DeliverAssemblyToCustomer(assembly: in assemblies.assemblyType; delivered: out Boolean) do
               if functions.CanDeliverAssembly(assembly) = True then
                  for P in products.productType loop
                     storage(P) := storage(P) - productsNeededForAssembly(assembly, P);
                     productsInStorage := productsInStorage - productsNeededForAssembly(assembly, P);
                  end loop;
                  delivered := True;
               else
                  delivered := False;
               end if;
            end DeliverAssemblyToCustomer;
         end select;
         functions.DisplayStorageContent;
      end loop;
   end Buffer;
end Buffer_Package;
