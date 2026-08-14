# Slothsoft's Minecraft Server

The Minecraft service runs the latest release with the Fabric loader and the
server-side Geyser, Floodgate, and Fabric API mods. Java clients connect normally
on TCP port 25565. Bedrock clients connect on UDP port 19132 and must globally
link their Bedrock and Java accounts at <https://link.geysermc.org/> before
joining; both clients then use the Java account's UUID and player data.

To return to a vanilla-only server, set `TYPE` back to `VANILLA`, remove the
managed mods, and remove the Bedrock UDP port. Fabric and vanilla use the same
world layout, but the world must not be opened with an older Minecraft version.
