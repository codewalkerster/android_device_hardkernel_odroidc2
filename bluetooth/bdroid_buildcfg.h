/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _BDROID_BUILDCFG_H
#define _BDROID_BUILDCFG_H

#define BTM_DEF_LOCAL_NAME "Odroid-c2"
// At present either USB or UART is supporteed
#define BLUETOOTH_HCI_USE_USB       TRUE
// SERVICE_CLASS:0x5A (Bit17 -Networking,Bit19 - Capturing,Bit20 -Object Transfer,Bit22 -Telephony)
// MAJOR CLASS: COMPUTER
// MINOR CLASS: reserved (no minor class for mbox)
#define BTA_DM_COD {0x5A, 0x01, 0x20}
#define BLE_PRIVACY_SPT		FALSE
// Bluetooth low Power Mode is supporteeed on BT4.0
#define HCILP_INCLUDED      FALSE

// 12.0 Updates
#define BLE_INCLUDED FALSE
#define BTA_GATT_INCLUDED FALSE
#define SMP_INCLUDED FALSE
#define PAN_NAP_DISABLED TRUE

/* Enable A2DP sink */
#define BTA_AV_SINK_INCLUDED TRUE

#endif
