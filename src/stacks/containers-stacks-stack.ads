with Ada.Finalization;
with Ada.Strings;
with Ada.Strings.Text_Buffers;

generic
   type Element_Type is private;

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
         Elements  : Elements_Access := new Elements_Type (10);
         Length : Count_Type := 0;
      end record with Put_Image => Put_Image;
   
   procedure Finalize (Container : in out Stack);
   
   procedure Put_Image
     (Stream    : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in     Stack);

end Containers.Stacks.Stack;
