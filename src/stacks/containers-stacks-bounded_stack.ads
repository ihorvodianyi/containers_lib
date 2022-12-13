generic
   type Element_Type is private;

package Containers.Stacks.Bounded_Stack is

   type Stack (Capacity : Count_Type) is private;

   function Length (Container : in Stack) return Count_Type;
   function Is_Empty (Container : in Stack) return Boolean;
   function Is_Full (Container : in Stack) return Boolean;
   procedure Clear (Container : in out Stack);

   function Element
     (Container : in Stack; Index : in Count_Type) return Element_Type;

   procedure Push
     (Container : in out Stack; New_Item : in Element_Type;
      Success   :    out Boolean);

   procedure Pop
     (Container : in out Stack; Element : out Element_Type;
      Success   :    out Boolean);

private

   type Element_Array is array (Count_Type range <>) of Element_Type;

   type Stack (Capacity : Count_Type) is record
      Elements : Element_Array (1 .. Capacity);
      Length   : Count_Type := 0;
   end record;

end Containers.Stacks.Bounded_Stack;
