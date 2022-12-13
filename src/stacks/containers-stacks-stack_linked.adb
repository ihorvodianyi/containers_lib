with Ada.Unchecked_Deallocation;

package body Containers.Stacks.Stack_Linked is
   
   procedure Free(Node : in out Node_Access);

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
      Node : Node_Access;
   begin
      if Container.Length = 0 then
         return;
      end if;
      
      while Container.Length > 0
      loop
         Node := Container.Head;
         Container.Head := Container.Head.Next;
         Free(Node);
         Container.Length := @ - 1;
      end loop;
   end Clear;
      
   ----------
   -- Push --
   ----------

   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean)
   is
      New_Node : Node_Access;
   begin
      if Container.Length < Container.Capacity
      then
         New_Node := new Node_Type'(New_Item, Container.Head);
         Container.Head := New_Node;
         Container.Length := @ + 1;
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
      Node : Node_Access;
   begin
      if Container.Length = 0 then
         Success := False;
      else
         Node := Container.Head;
         Container.Head := Container.Head.Next;
         Element := Node.Element;
         Free(Node);
         Container.Length := @ - 1;
         Success := True;
      end if;
   end Pop;
      
   ----------
   -- Free --
   ----------

   procedure Free(Node : in out Node_Access) is
      procedure Deallocate is
        new Ada.Unchecked_Deallocation (Node_Type, Node_Access);

   begin
      Node.Next := Node;
      Deallocate(Node);
   end Free;   
   
   --------------
   -- Finalize --
   --------------

   procedure Finalize(Container : in out Stack)
   is
   begin
      Clear(Container);
   end Finalize;

end Containers.Stacks.Stack_Linked;
