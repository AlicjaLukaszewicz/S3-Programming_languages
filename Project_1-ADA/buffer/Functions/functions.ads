with assemblies;
with products;

package functions is
   
   function IsThereFreeSpaceInStorage return Boolean;
   function CanDeliverAssembly(Assembly: assemblies.assemblyType) return Boolean;
   function CanAcceptProductIntoStorage(Product: products.productType) return Boolean;
   
   procedure DisplayStorageContent;

end functions;
