with Ada.Strings;
with Ada.Strings.Text_Buffers;
with Containers.Stack.Stack_Interface;

generic
   type Element_Type is private;

package Containers.Stack.Bounded_Stack is

   package Stack_Interface is
     new Containers.Stack.Stack_Interface (Element_Type);

   type Stack (Capacity : Count_Type) is private;
   
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

   type Stack (Capacity : Count_Type) is record
      Nodes  : Element_Array (0 .. Capacity);
      Length : Count_Type := 0;
   end record with Put_Image => Put_Image;
   
   procedure Put_Image
     (Stream    : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in     Stack);

end Containers.Stack.Bounded_Stack;
