with Ada.Text_IO; use Ada.Text_IO;
with Buffer_Package;

with products;

package body functions is

   function IsThereFreeSpaceInStorage return Boolean is
   begin
      if Buffer_Package.productsInStorage < Buffer_Package.storageCapacity then
         return True;
      else 
         return False;
      end if;
   end IsThereFreeSpaceInStorage;
   
   procedure DisplayStorageContent is 
   begin
      Put_Line(" ");
      Put_Line("Storage contents: ");
      for P in products.productType loop 
         Put_Line("   " & Integer'Image(Buffer_Package.storage(P)) & " " & products.productName(P));
      end loop;
      Put_Line(" ");
   end DisplayStorageContent;
   
   function CanDeliverAssembly(Assembly: assemblies.assemblyType) return Boolean is
   begin
      for P in products.productType loop
         if Buffer_Package.storage(P) < Buffer_Package.productsNeededForAssembly(Assembly, P) then
            return False;
         end if;
      end loop;
      return True;
   end CanDeliverAssembly;
   
   function CanAcceptProductIntoStorage(Product: products.productType) return Boolean is
      freeRoomInStorage: Integer;
   
      productsLackingForAssembly: array(products.productType) of Integer;
      roomNeededToProduceAssembly: Integer;
      canAccept: Boolean;			
      productNumber: Integer := Product;
      maxNumberOfProductsForAssembly: Integer := 0;
   begin
      if IsThereFreeSpaceInStorage = True then
         freeRoomInStorage := Buffer_Package.storageCapacity - Buffer_Package.productsInStorage;
         canAccept := True;
         
         for P in products.productType loop
            if Buffer_Package.storage(P) < Buffer_Package.maxAssemblyContent(P) then
               canAccept := False;
            end if;
         end loop;
         
         for A in assemblies.assemblyType loop
            maxNumberOfProductsForAssembly := 
              Integer'Max(maxNumberOfProductsForAssembly, Buffer_Package.productsNeededForAssembly(A, productNumber));
         end loop;
         
         if Buffer_Package.storage(productNumber) >= 3*maxNumberOfProductsForAssembly then
            Put_Line("Product would exceed limit for its intended room: " & products.productName(productNumber));
            return False;
         end if;
         
         if canAccept = True then
            return True;		
         end if;
            
         if Integer'Max(0, Buffer_Package.maxAssemblyContent(Product) - Buffer_Package.storage(Product)) > 0 then
            return True;
         end if;
            
         roomNeededToProduceAssembly := 1;
            
         for P in products.productType loop
            productsLackingForAssembly(P) := Integer'Max(0, Buffer_Package.maxAssemblyContent(P) - Buffer_Package.storage(P));
            roomNeededToProduceAssembly := roomNeededToProduceAssembly + productsLackingForAssembly(P);
         end loop;
            
         if freeRoomInStorage >= roomNeededToProduceAssembly then
            return True;
         else
            return False;
         end if;
      else
         return false;
      end if; 
   end CanAcceptProductIntoStorage;
end functions;
