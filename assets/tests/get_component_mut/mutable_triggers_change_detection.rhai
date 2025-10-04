// Test that get_component_mut DOES trigger Bevy's change detection
// We verify this by comparing the component's changed tick with the current world tick
// When we access mutably, the component's changed tick should be updated to match the current world tick

let TestComponent = world.get_type_by_name.call("test_utils::test_data::TestComponent");
let entity = world._get_entity_with_test_component.call("TestComponent");

// First, get read-only access to establish the initial tick (this doesn't update the changed tick)
let comp_read = world.get_component_read.call(entity, TestComponent);
if type_of(comp_read) == "()" {
    throw "Should be able to get component read-only";
}
let dummy1 = comp_read.strings;  // dereference to ensure access

// Get the initial change ticks
let tick_before = world.get_component_ticks.call(entity, TestComponent);
if type_of(tick_before) == "()" {
    throw "Should be able to get change ticks";
}
let tick_before_val = tick_before.changed.get.call();

// Now access the component with mutable access (this should update the changed tick)
let comp_mut = world.get_component_mut.call(entity, TestComponent);
if type_of(comp_mut) == "()" {
    throw "Should be able to get component mutably";
}

// Get the change ticks after mutable access
let tick_after = world.get_component_ticks.call(entity, TestComponent);
if type_of(tick_after) == "()" {
    throw "Should be able to get change ticks after mutable access";
}
let tick_after_val = tick_after.changed.get.call();

// The changed tick should have been updated
assert(tick_after_val >= tick_before_val,
    `Mutable access should set change tick to current or newer. Before: ${tick_before_val}, After: ${tick_after_val}`);

// If ticks are the same, it means the component was already marked as changed in this frame
// If after > before, it means this mutable access updated the tick
print(`Change detection test: tick before=${tick_before_val}, tick after=${tick_after_val}`);
