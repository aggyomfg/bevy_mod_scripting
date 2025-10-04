-- Test that mutable component references can be mutated
local TestComponent = world.get_type_by_name("test_utils::test_data::TestComponent")
local entity_with_test_comp = world._get_entity_with_test_component("TestComponent")

-- Get mutable reference
local comp_mut = world.get_component_mut(entity_with_test_comp, TestComponent)
assert(comp_mut ~= nil, "Should get mutable component")

-- Mutate - this should work
comp_mut.strings[1] = "Modified"

-- Verify the mutation worked
local comp_check = world.get_component_read(entity_with_test_comp, TestComponent)
assert(comp_check.strings[1] == "Modified",
    "Mutation should have persisted, but got: " .. tostring(comp_check.strings[1]))
