with products;

package Producer_Package is
   task type Producer is
      entry StartProducing(Product: in products.productType);
   end Producer;
end Producer_Package;
