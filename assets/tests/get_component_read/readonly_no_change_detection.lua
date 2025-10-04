-- Test that get_component_read does NOT trigger Bevy's change detection
-- by verifying the changed tick stays the same after read-only access
local TestComponent = world.get_type_by_name("test_utils::test_data::TestComponent")
local entity = world._get_entity_with_test_component("TestComponent")

-- Get the initial change ticks
local tick_before = world.get_component_ticks(entity, TestComponent)
assert(tick_before ~= nil, "Should be able to get change ticks")
local tick_before_val = tick_before.changed:get()

-- Access the component multiple times with read-only access
for i = 1, 3 do
    local comp_read = world.get_component_read(entity, TestComponent)
    assert(comp_read ~= nil, "Should be able to get component read-only")

    -- Actually read the component data to ensure it's dereferenced
    local strings = comp_read.strings
    assert(strings ~= nil, "Should be able to read strings")
    assert(strings[1] == "Initial", "Should read initial value")

    -- Check ticks haven't changed
    local tick_check = world.get_component_ticks(entity, TestComponent)
    assert(tick_check ~= nil, "Should be able to get change ticks")
    local tick_check_val = tick_check.changed:get()

    assert(tick_before_val == tick_check_val,
        "Read-only access should NOT trigger change detection (iteration " .. tostring(i) .. "). Before: " ..
        tostring(tick_before_val) .. ", After: " .. tostring(tick_check_val))
end
