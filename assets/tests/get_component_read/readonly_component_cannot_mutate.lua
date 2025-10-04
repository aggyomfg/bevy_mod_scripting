-- Test that read-only component references cannot be mutated
local TestComponent = world.get_type_by_name("test_utils::test_data::TestComponent")
local entity_with_test_comp = world._get_entity_with_test_component("TestComponent")

-- Get read-only reference
local comp_read = world.get_component_read(entity_with_test_comp, TestComponent)
assert(comp_read ~= nil, "Should get read-only component")

-- Try to mutate - this should fail
local success, err = pcall(function()
    comp_read.strings[1] = "Modified"
end)

assert(not success, "Should not be able to mutate read-only component")
assert(string.find(tostring(err), "read%-only") or string.find(tostring(err), "Cannot mutate"),
    "Error should mention read-only: " .. tostring(err))
