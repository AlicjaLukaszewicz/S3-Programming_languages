with consumers;
package Consumer_Package is
   task type Consumer is
      entry StartConsuming(Consumer: in consumers.consumerType);
   end Consumer;
end Consumer_Package;
