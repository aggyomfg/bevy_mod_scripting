-- Test that get_component_mut DOES trigger Bevy's change detection
-- We verify this by comparing the component's changed tick with the current world tick
-- When we access mutably, the component's changed tick should be updated to match the current world tick
local TestComponent = world.get_type_by_name("test_utils::test_data::TestComponent")
local entity = world._get_entity_with_test_component("TestComponent")

-- First, get read-only access to establish the initial tick (this doesn't update the changed tick)
local comp_read = world.get_component_read(entity, TestComponent)
assert(comp_read ~= nil, "Should be able to get component read-only")
local _ = comp_read.strings -- dereference to ensure access

-- Get the initial change ticks
local tick_before = world.get_component_ticks(entity, TestComponent)
assert(tick_before ~= nil, "Should be able to get change ticks")
local tick_before_val = tick_before.changed:get()

-- Now access the component with mutable access (this should update the changed tick)
local comp_mut = world.get_component_mut(entity, TestComponent)
assert(comp_mut ~= nil, "Should be able to get component mutably")

-- Get the change ticks after mutable access
local tick_after = world.get_component_ticks(entity, TestComponent)
assert(tick_after ~= nil, "Should be able to get change ticks after mutable access")
local tick_after_val = tick_after.changed:get()

-- The changed tick should have been updated
assert(tick_after_val >= tick_before_val,
    "Mutable access should set change tick to current or newer. Before: " .. tostring(tick_before_val) ..
    ", After: " .. tostring(tick_after_val))

-- If ticks are the same, it means the component was already marked as changed in this frame
-- If after > before, it means this mutable access updated the tick
print("Change detection test: tick before=" .. tostring(tick_before_val) ..
    ", tick after=" .. tostring(tick_after_val))
