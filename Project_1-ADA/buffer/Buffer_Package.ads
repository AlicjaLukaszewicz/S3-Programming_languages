with products;
with assemblies;

package Buffer_Package is
   storageCapacity: constant Integer := 30;
   productsInStorage: Integer := 0;
   
   storage: array (products.productType) of Integer
     := (0, 0, 0, 0, 0);
     
   productsNeededForAssembly: array (assemblies.assemblyType, products.productType) of Integer
     := ((0, 2, 3, 1, 1),
         (2, 1, 0, 1, 1),
         (3, 0, 1, 2, 2));

   maxAssemblyContent: array(products.productType) of Integer;

   task type Buffer is
      entry TakeProductToStorage(product: in products.productType);
      entry DeliverAssemblyToCustomer(assembly: in assemblies.assemblyType; delivered: out Boolean);
   end Buffer;
   
   B: Buffer;
   
end Buffer_Package;
