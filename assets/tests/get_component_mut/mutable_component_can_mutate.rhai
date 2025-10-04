// Test that mutable component references can be mutated
let TestComponent = world.get_type_by_name.call("test_utils::test_data::TestComponent");
let entity_with_test_comp = world._get_entity_with_test_component.call("TestComponent");

// Get mutable reference
let comp_mut = world.get_component_mut.call(entity_with_test_comp, TestComponent);
let strings = comp_mut.strings;
strings[0] = "Modified";

// Verify the mutation worked
let comp_check = world.get_component_read.call(entity_with_test_comp, TestComponent);
let result = comp_check.strings[0];
assert(result == "Modified",
    "Mutation should have persisted, but got: " + result);
