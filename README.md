# Make your own base map or overlay tiles with MapLibre stack and Planetiler

<img src="https://openstreetmap.us/img/pages/sotmus/2025/logo.png" width="30%" />

Welcome to our workshop organized by [MapLibre](https://maplibre.org/)! We hope you will have fun and learn something useful.

## Your Hosts

- [Yuri Astrakhan](https://github.com/nyurik)
- [Mike Barry](https://github.com/msbarry)
- [Bart Louwers](https://github.com/louwers)

## Goal

1. Create your own vector tiles with [Planetiler](https://github.com/onthegomap/planetiler).
2. Host the vector tiles you created with [Martin](https://martin.maplibre.org/).
3. Learn how create a MapLibre style with [Maputnik](https://github.com/maplibre/maputnik).
4. Intergrate your map on a web page with [MapLibre GL JS](https://github.com/maplibre/maplibre-gl-js).

## Setting up Development Environment

To make best use of the time available for this workshop, we will use [GitHub Codespaces](https://github.com/features/codespaces) to set up the development environment.

Go to the [workshop repository](https://github.com/maplibre/workshop), in the top right click the *Code*, then go to the *Codespaces* tab and click the right button to start a new codespace.

<img src="https://github.com/user-attachments/assets/0a398a4a-cfbe-4275-8c58-9cd92f9d73e3" width="50%" />

After downloading the Docker image that we prepared for you you will be dropped into a shell. If not, click the small Plus sign above the terminal window to create another shell.

## 1. Tile Generation

We already downloaded an Boston OSM extract created with [slice.openstreetmap.us](https://slice.openstreetmap.us/).

Run the following command.

```
java -jar /planetiler.jar --download_dir=/data/sources --minzoom=0 --maxzoom=14 --osm_path=/data/sources/massachusetts.osm.pbf
```

## 2. Tile Serving

The MBTiles file that was generated in the previous step can be hosted with a tile server. In this workshop we will use Martin, which is pre-installed to the development container.

Run the following command:

```
martin data/output.mbtiles
```

Martin will launch on port 3000. You will get a prompt to expose this port. Expose the port to the internet.

Go to the Ports tab in VS Code to see the public URL for your Martin instance.

![image](https://github.com/user-attachments/assets/c5bcf8c4-416d-49b1-b0be-2ca04ea6267b)

Make sure it is set to "Public" you can right-click to change the Visibility.

When you open the URL it shows, you should see the message:

```
Martin server is running.


    The WebUI feature can be enabled with the --webui enable-for-all CLI flag or in the config file, making it available to all users.


    A list of all available sources is at /catalog

See documentation https://github.com/maplibre/martin
```

Go to the catalog, and then to `/output`. This is a TileJSON endpoint which describes the tiles hosted at that path.

## 3. Styling your map

Go to [Maputnik](https://maplibre.org/maputnik), click open and open the empty style. Next, add a new source. Use the URL of your Martin instance with the `/output` TileJSON endpoint.

Since you don't have any layers, you will not see anything visualized. Hower, you can switch from the 'Map' view to the 'Inspect' view to see the data contained in your tiles. If it looks something like this, you are doing great so far!

![alt text](image-1.png)

Note that we only have detailed tiles in Massachusetts due to the OSM extract that we used. To generate vector tiles for the entire world would require a more powerful server than the one that GitHub Codespaces offers!

Try adding some layers. Refer to the [MapLibre Style Spec](https://maplibre.org/maplibre-style-spec/) to see what kind of layers you can add. An easy one might be one for the ocean or other water bodies.

Check out what attributes exist in the Inspect view or refer to the documentation of the [OpenMapTiles Schema](https://openmaptiles.org/schema/), which is the tile schema that Planetiler uses by default.

## 4. Creating a Web Page with MapLibre

When you are happy with the style you are created, go to *Save* in the top bar and then *Create HTML*.

Create an index.html in your Codespace and paste the contents of the HTML file that was downloaded. Next, launch a simple web server and expose it to the internet like before.

```
python -m http.server 1234
```

If everything went well, you will have created your own basemap and deployed it in under one hour!

Take a closer look to the generated HMTL to understand how MapLibre GL JS is set up. Explore the [MapLibre GL JS](https://maplibre.org/maplibre-gl-js/docs/) documentation to see what APIs exist. Try for example to add markers to the map when you click somewhere.
