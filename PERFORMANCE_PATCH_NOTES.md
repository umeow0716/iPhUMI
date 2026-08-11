# iPhUMI high-performance / no-depth patch

This build keeps the stock iPhUMI data path required for RGB policy training and gripper AprilTag processing while removing depth collection overhead.

## Data collection changes

- ARKit `sceneDepth` is disabled and explicitly removed from the recording configuration.
- New recordings no longer create `*_depth.raw` or `*_depthpreview.mp4`.
- `hasDepth` remains in JSON and is written as `false` for compatibility with existing processing code.
- Legacy depth save types remain in the app so old recordings can still be viewed/deleted.
- Export intentionally copies only JSON, main RGB, and ultrawide RGB. Existing legacy depth files are not exported.
- Ultrawide RGB is retained because stock iPhUMI gripper calibration / AR-tag detection depends on it.

## Runtime optimizations

- Environment texturing is disabled during data collection.
- ARKit collaboration is enabled only when Multipeer Connectivity is enabled.
- ARKit audio output is requested only when voice recognition or a connected contact microphone needs it.
- RGB writers create AAC inputs only when a contact microphone is actually being recorded.
- H.264 and AAC encoder warm-up are separated; AAC is only warmed when a contact microphone is present.
- Per-frame UI/readiness refresh is throttled from ~60 Hz to 10 Hz while pose validation and recording remain full-rate.
- Ultrawide lens-position probing is throttled to at most 2 Hz until cached.
- ISO8601 formatter construction is cached instead of allocating a new formatter per frame.
- Removed unused per-frame ultrawide timestamp/date and debug string calculations.

## Python processing compatibility

`align.py` now handles recordings with empty `depthTimes` by emitting valid placeholder depth indices. This keeps the stock visualization path functional when depth is intentionally absent. Dataset generation already defaults to `include_depth: false`.

## Validation performed

- Parsed all Swift sources with Swift 6.2 frontend syntax parser.
- Compiled all Python package sources with `compileall`.
- Audited the data-collection tree for any remaining depth capture/writer calls.
- Audited export types to ensure depth files are omitted.
- Confirmed main RGB and ultrawide recording paths remain enabled.
- Confirmed stock ultrawide AR-tag detection path remains unchanged.
- Confirmed Xcode project files and deployment depth-streaming code were not modified.
