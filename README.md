# Slothsoft's Minecraft Server

The Minecraft service runs the latest release with the Fabric loader and the
server-side Geyser, Floodgate, and Fabric API mods. Java clients connect normally
on TCP port 25565. Bedrock clients connect using NetherNet on TCP port 19132
(signaling) and UDP port 19132 (gameplay), and must globally
link their Bedrock and Java accounts at <https://link.geysermc.org/> before
joining; both clients then use the Java account's UUID and player data.

Set `JAVA_PORT` and `BEDROCK_PORT` in the stack environment to choose the published
ports. They default to 25565 and 19132; `BEDROCK_PORT` controls both TCP signaling
and UDP gameplay, including Geyser's advertised public port. Internal container
ports stay at 25565 and 19132.

For the creative stack, use `STACK_NAME=minecraft-creative`,
`SERVER_NAME=minecraft-creative.slothsoft.net`, `JAVA_PORT=25566`, and
`BEDROCK_PORT=19133`. Each stack uses its own existing `${STACK_NAME}_world`
volume; the Floodgate configuration remains shared. The world services otherwise
use the same runtime configuration, with gameplay settings retained in their
separate data volumes.

The stack downloads the latest stable Geyser Fabric build at startup. NetherNet
requires Geyser build 1237 or newer; JVM properties in the stack enable it and
override the persisted Geyser configuration. `SERVER_NAME` must resolve to the
public server address, which Geyser advertises to clients from inside Docker.
Both TCP and UDP on `BEDROCK_PORT` must be allowed through the host firewall and any
upstream port forwarding. Players keep their existing server address and port.

Signaling uses HTTP, so Bedrock players see a trust prompt on their first join.
HTTPS can be configured later using Geyser's certificate support or a reverse
proxy: <https://geysermc.org/wiki/geyser/nethernet-https/>.

After deployment, check the world service logs for NetherNet and built-in
signaling startup errors, then join with a Bedrock 26.40 or newer client using a
globally linked account. Confirm that the Java account's existing player data
is used. This configuration replaces RakNet and does not accept older clients.
Migration reference: <https://geysermc.org/blog/preparing-for-nethernet/>.

To return to a vanilla-only server, set `TYPE` back to `VANILLA`, remove the
managed mods and Geyser JVM properties, and remove both Bedrock port mappings.
Fabric and vanilla use the same
world layout, but the world must not be opened with an older Minecraft version.
