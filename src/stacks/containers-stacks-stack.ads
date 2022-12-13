with Ada.Finalization;

generic
   type Element_Type is limited private;

package Containers.Stacks.Stack is

   type Stack (Capacity : Count_Type) is limited private;
   
   function Length (Container : in Stack) return Count_Type;
   function Is_Empty (Container : in Stack) return Boolean;
   function Is_Full (Container : in Stack) return Boolean;

   procedure Clear (Container : in out Stack);

   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean);
   
   procedure Pop
     (Container : in out Stack;
      Element   : out Element_Type;
      Success   : out Boolean);
   
private
   
   type Element_Array is array (Count_Type range <>) of Element_Type;
   
   type Elements_Type (size : Count_Type) is limited record
      Elements : Element_Array (1 .. size);
   end record;
   
   type Elements_Access is access all Elements_Type;

   type Stack (Capacity : Count_Type) is new Ada.Finalization.Limited_Controlled with
      record
         Elements : Elements_Access := new Elements_Type (10);
         Length   : Count_Type := 0;
      end record;
   
   procedure Finalize (Container : in out Stack);

end Containers.Stacks.Stack;
