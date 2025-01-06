
# README for the ExpRate System

---

## Overview

The ExpRate system is a Lua-based project designed for World of Warcraft 3.3.5 (AzerothCore) to manage customizable experience rates for players. It includes both server-side and client-side components, enabling seamless interaction between the game server and the player UI. **This system requires the [AIO (All-In-One)](https://github.com/azerothcore/mod-aio) module to function correctly.**

---

## File Structure

### 1. Server-side (Scripts are placed in `scripts_lua`)
- **`1_ExpRateModel.lua`**:
  - Handles database operations to retrieve and update player-specific experience rates.
- **`2_ExpRateController.lua`**:
  - Acts as the intermediary between the model and other modules, ensuring proper rate handling logic.
- **`4_ExpRateAIO.lua`**:
  - Manages AIO communication between the server and client, handling requests such as setting and updating experience rates.
- **`exp_rate_hook.lua`**:
  - Hooks into game events (`OnGiveXP` and `OnQuestReward`) to apply customized experience rates dynamically.
- **`create_player_exp_rates.sql`**:
  - SQL script to set up the necessary database table (`player_exp_rates`) for storing player-specific experience rates.

### 2. Client-side (Located in `World of Warcraft 335a\Interface\AddOns`)
- **`ExpRateClient.lua`**:
  - Adds a UI component (icon) to the player's frame, allowing them to interactively choose their experience rate.

---

## Features

### Server-side:
- Database-backed experience rate management with player-specific settings.
- Support for dynamic rate adjustments based on player location (e.g., instance multipliers).
- Hooks to modify XP gains for combat and quest rewards.

### Client-side:
- User-friendly interface to allow players to select their desired experience rate.
- Real-time feedback and updates using AIO communication.

---

## Setup Instructions

### 1. Database Setup
- Run the `create_player_exp_rates.sql` file in your database to create the necessary table for storing player-specific experience rates.

### 2. Server-side Installation
- Place the following Lua scripts in the `scripts_lua` directory of your AzerothCore server:
  - `1_ExpRateModel.lua`
  - `2_ExpRateController.lua`
  - `4_ExpRateAIO.lua`
  - `exp_rate_hook.lua`

### 3. Client-side Installation
- Copy the `ExpRateClient.lua` file to the `World of Warcraft 335a\Interface\AddOns` directory.
- Ensure the game client is configured to load custom addons.

### 4. Testing
- Log in with a test character.
- Verify the UI icon appears on the player frame.
- Test setting experience rates and observe server-side handling in real-time.

---

## Usage

### Changing Experience Rates (Client)
- Click the "Experience Rate" icon on your player frame.
- Select a rate from the dropdown menu (1x to 5x).
- Observe real-time confirmation of the rate change.

### Event Handling (Server)
- XP gains are dynamically adjusted using the rate selected by the player.
- Instance multipliers are applied automatically when the player is inside a designated dungeon or raid.

---

## Troubleshooting

- Ensure all server-side scripts are loaded correctly by verifying logs for `[DEBUG]` messages.
- Verify the database table `player_exp_rates` exists and is populated correctly.
- If the client icon does not appear, confirm the `ExpRateClient.lua` file is in the correct addon directory and is enabled in the client.

---



For questions or further assistance, please reach out to [Your Contact Information].
