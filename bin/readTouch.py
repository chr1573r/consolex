# Returns 0 or 1 to shell, depending on touch screen is pressed
import sys
from evdev import InputDevice
dev = InputDevice('/dev/input/event0')
keys=dev.active_keys()
if keys:
        if keys[0] == 330:
                sys.exit(0)
else:
        sys.exit(1)

