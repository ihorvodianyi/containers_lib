package body Containers.Stacks.Bounded_Stack is

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

   procedure Clear (Container : in out Stack) is
   begin
      Container.Length := 0;
   end Clear;

   -------------
   -- Element --
   -------------

   function Element
     (Container : in Stack; Index : Count_Type) return Element_Type
   is
   begin
      return Container.Elements (Index);
   end Element;

   ----------
   -- Push --
   ----------

   procedure Push
     (Container : in out Stack;
      New_Item  : in     Element_Type;
      Success   :    out Boolean)
   is
   begin
      if Container.Length < Container.Capacity then
         Container.Length := @ + 1;
         Container.Elements (Container.Length) := New_Item;
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
      Element   :    out Element_Type;
      Success   :    out Boolean)
   is
   begin
      if Container.Length = 0 then
         Success := False;
      else
         Element := Container.Elements (Container.Length);
         Container.Length := @ - 1;
         Success := True;
      end if;
   end Pop;

end Containers.Stacks.Bounded_Stack;
