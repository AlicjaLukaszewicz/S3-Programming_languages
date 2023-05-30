package assemblies is
   nAssemblyTypes: constant Integer := 3;
   
   subtype assemblyType is Integer range 1 .. nAssemblyTypes;
   
   assemblyName: constant array (assemblyType) of String(1 .. 38)
     := ("2*Pot, 3*Seeds, 1*Soil, 1*Fertilizer  ",
         "2*Plant, 1*Pot, 1*Soil, 1*Fertilizer  ",
         "3*Plant, 1*Seeds, 2*Soil, 2*Fertilizer");
end assemblies;
