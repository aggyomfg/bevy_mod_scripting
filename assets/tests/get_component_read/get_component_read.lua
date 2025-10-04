-- Test read-only component access doesn't trigger change detection
local TestComponent = world.get_type_by_name("test_utils::test_data::TestComponent")
local entity = world._get_entity_with_test_component("TestComponent")

-- Get read-only reference
local comp_read = world.get_component_read(entity, TestComponent)
assert(comp_read ~= nil, "Should be able to get component read-only")

-- Read the strings field
local strings = comp_read.strings
assert(strings ~= nil, "Should be able to read strings")
assert(strings[1] == "Initial", "Should read initial value")
