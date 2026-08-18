# Day 4 Challenges

## 1. LWC Deployment

Initially, the LWC deployment command from VS Code was not working correctly.

### Solution

Used the Salesforce CLI deployment command with the connected org alias.

## 2. Lightning App Builder

The component had to be deployed and activated on the correct Lightning Page before it could be tested.

## 3. LWC HTML Root Element

An LWC compile error occurred because the HTML file had multiple root elements.

### Solution

Wrapped the complete component markup inside a single `<template>` root element.

## 4. JavaScript Interaction

The welcome message and application status required JavaScript event handlers.

### Solution

Used button click handlers to update component properties.
