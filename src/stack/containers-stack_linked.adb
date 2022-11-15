with Ada.Unchecked_Deallocation;

package body Containers.Stack_Linked is
   
   procedure Free(Node : in out Node_Access);
   
   function Length (Container : in Stack) return Count_Type is
   begin
      return Container.Length;
   end Length;
   
   function Is_Empty (Container : in Stack) return Boolean is
   begin
      return Container.Length = 0;
   end Is_Empty;
   
   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean)
   is
      New_Node : Node_Access;
   begin
      if Container.Length < Container.Capacity then
         New_Node := new Node_Type'(New_Item, Container.Head);
         Container.Head := New_Node;
         Container.Length := Container.Length + 1;
         Success := True;
      else
         Success := False;
      end if;                  
   end Push;
   
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
         Container.Length := Container.Length - 1;
         Success := True;
      end if;
   end Pop;
   
   procedure Free(Node : in out Node_Access) is
      procedure Deallocate is
        new Ada.Unchecked_Deallocation (Node_Type, Node_Access);

   begin
      --  While a node is in use, as an active link in a list, its Previous and
      --  Next components must be null, or designate a different node; this is
      --  a node invariant. Before actually deallocating the node, we set both
      --  access value components of the node to point to the node itself, thus
      --  falsifying the node invariant. Subprogram Vet inspects the value of
      --  the node components when interrogating the node, in order to detect
      --  whether the cursor's node access value is dangling.

      --  Note that we have no guarantee that the storage for the node isn't
      --  modified when it is deallocated, but there are other tests that Vet
      --  does if node invariants appear to be satisifed. However, in practice
      --  this simple test works well enough, detecting dangling references
      --  immediately, without needing further interrogation.

      Node.Next := Node;
      Deallocate(Node);
   end Free;

   

end Containers.Stack_Linked;
