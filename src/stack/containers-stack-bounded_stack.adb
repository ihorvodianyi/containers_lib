package body Containers.Stack.Bounded_Stack is

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
   begin
      if Container.Length < Container.Capacity
      then
         Container.Length := Container.Length + 1;
         Container.Nodes(Container.Length) := New_Item;                  
         Success := True;
      else
         Success := False;
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
         Element := Container.Nodes(Container.Length);
         Container.Length := Container.Length - 1;
         Success := True;
      end if;
   end Pop;
   
   ---------------
   -- Put_Image --
   ---------------

   procedure Put_Image
     (Stream : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in Stack)
   is
   begin
      Stream.Put("{Capacity: " & Container.Capacity'Image & " | Length: " & Container.Length'Image & " | Array: [");    
      for index in 1..Container.Length
      loop
         Element_Type'Put_Image(Stream, Container.Nodes(index));
      end loop;
      Stream.Put("]}");
   end Put_Image;

end Containers.Stack.Bounded_Stack;
