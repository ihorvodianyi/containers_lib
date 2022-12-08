with Ada.Unchecked_Deallocation;

package body Containers.Stacks.Stack is
   
   procedure Free is
     new Ada.Unchecked_Deallocation (Elements_Type, Elements_Access);

   ------------
   -- Length --
   ------------

   function Length (Container : in Stack) return Count_Type is
   begin
      return Container.Length;
   end Length;
   
   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Container : in Stack) return Boolean is
   begin
      return Container.Length = 0;
   end Is_Empty;
   
   -------------
   -- Is_Full --
   -------------

   function Is_Full (Container : in Stack) return Boolean is
   begin
      return Container.Length = Container.Capacity;
   end Is_Full;
   
   -----------
   -- Clear --
   -----------

   procedure Clear (Container : in out Stack)
   is
   begin
      Container.Length := 0;
   end Clear;
      
   ----------
   -- Push --
   ----------

   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean)
   is
      Dst : Elements_Access;
   begin
      if Container.Length < Container.Elements.size
      then
         Container.Length := Container.Length + 1;
         Container.Elements.Elements(Container.Length) := New_Item;                  
         Success := True;
      else
         if Container.Elements.size = Container.Capacity
         then
            Success := False;
         else
            if Container.Elements.size * 2 > Container.Capacity
            then
               Dst := new Elements_Type (Container.Capacity);
            else
               Dst := new Elements_Type (Container.Elements.size * 2);
            end if;
            Dst.Elements (1..Container.Elements.size) := Container.Elements.Elements (1..Container.Elements.size);
            Free (Container.Elements);
            Container.Elements := Dst;
            Container.Length := Container.Length + 1;
            Container.Elements.Elements(Container.Length) := New_Item;
            Success := True;
         end if;
      end if;                  
   end Push;
   
   ---------
   -- Pop --
   ---------

   procedure Pop
     (Container : in out Stack;
      Element   : out Element_Type;
      Success   : out Boolean)
   is
   begin
      if Container.Length = 0 then
         Success := False;
      else
         Element := Container.Elements.Elements(Container.Length);
         Container.Length := Container.Length - 1;
         Success := True;
      end if;
   end Pop;
   
   
   --------------
   -- Finalize --
   --------------

   procedure Finalize (Container : in out Stack) is
   begin
      Free (Container.Elements);
   end Finalize;
      
   ---------------
   -- Put_Image --
   ---------------

   procedure Put_Image
     (Stream    : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in Stack)
   is
   begin
      Stream.Put("{Capacity: " & Container.Capacity'Image & " | Length: " & Container.Length'Image & "| Size: " & Container.Elements.size'Image & " | Array: [");    
      for index in 1..Container.Length
      loop
         Element_Type'Put_Image(Stream, Container.Elements.Elements(index));
      end loop;
      Stream.Put("]}");
   end Put_Image;


end Containers.Stacks.Stack;
