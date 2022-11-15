package Containers is
   pragma Pure;

   Max_Count : constant := 2**31 - 1;

   type Count_Type is range 0 .. Max_Count;
   --  Represents the (potential or actual) number of elements of a container

end Containers;
