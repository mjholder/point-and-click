# CURRENT NODE STRUCTURE

## Main Scene (game.tscn)
```
Node2D (game)
├── Sprite2D (background)
│   └── scale: Vector2(8, 8)
│   └── texture: background.png
├── Level (Node2D) - instance of level.tscn
│   └── position: Vector2(-128, -128)
│   └── visibility_layer: 2
│   └── TileMapLayer (map)
│       └── visibility_layer: 2
│       └── tile_set: Custom TileSet
├── Player (CharacterBody2D) - instance of player.tscn
│   └── position: Vector2(-112, -112)
│   └── collision_layer: 15
│   └── collision_mask: 11
│   └── StateMachine (Node)
│   ├── IdleState (Node)
│   ├── WalkingState (Node)
│   └── SuccessState (Node)
├── Cat (CharacterBody2D) - instance of cat.tscn
│   └── position: Vector2(16, 16)
│   └── StateMachine (Node)
│   ├── IdleState (Node)
│   ├── CatWalkState (Node)
│   └── CatSuccessState (Node)
├── Pathfinder (Node)
│   └── script: pathfinder.gd
│   └── level: NodePath("../level")
├── Camera2D
└── CanvasLayer
    └── follow_viewport_enabled: true
    └── GUI (Control)
        └── layout_mode: 3
        └── anchors: full screen
        └── EndTurnButton (TextureButton)
            └── anchors: bottom-right
            └── scale: Vector2(8, 8)
```

## Level Scene (level.tscn)
```
Node2D (level)
└── TileMapLayer (map)
    └── visibility_layer: 2
    └── tile_set: Custom TileSet with 2 sources
        ├── Source 0: tile.png (32x32 tiles)
        └── Source 1: tile_highlight.png (32x32 tiles)
```

## Player Scene (player.tscn)
```
CharacterBody2D (Player)
├── StateMachine (Node)
├── IdleState (Node)
├── WalkingState (Node)
└── SuccessState (Node)
```

## Cat Scene (cat.tscn)
```
CharacterBody2D (Cat)
├── StateMachine (Node)
├── IdleState (Node)
├── CatWalkState (Node)
└── CatSuccessState (Node)
```

## Script Dependencies
- **game.gd** (Node2D) - Main game controller
- **level.gd** (Node2D) - Level management and tile highlighting
- **player.gd** (CharacterBody2D) - Player movement and state management
- **cat.gd** (CharacterBody2D) - Cat AI and state management
- **pathfinder.gd** (Node) - A* pathfinding logic
- **state_machine.gd** (Node) - State machine base class
- **state.gd** (Node) - Individual state base class
- **idle_state.gd** (Node) - Idle behavior
- **walking_state.gd** (Node) - Walking behavior
- **success_state.gd** (Node) - Success behavior
- **cat_walk_state.gd** (Node) - Cat walking behavior
- **cat_success_state.gd** (Node) - Cat success behavior

## Key Relationships
- **Pathfinder** references **Level** for map data
- **Game** controls **Player** and **Cat** movement
- **Level** handles tile highlighting for both player and cat paths
- **State Machines** manage behavior for both Player and Cat
- **Camera2D** follows the game world
- **CanvasLayer** keeps UI elements on top
