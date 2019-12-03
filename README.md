#  Instances Generator: WTF?

OK, here it is. 

### If you know what MultipleMaster or Variable Font is, it will be much easier to understand what this software do.

If you design or developing font in MM or VariableFont technology, sometimes happened that particular Masters does not fit to each other — i.e. BlackCondensed could be to wide to pair with ThinCondensed or BlackCondesed could have different ”blackness” than BlackExtended. 
There are two ways to deal with problem: to redesign masters or set their coordiantes in nice-looking places. 
But in this second approach setting coordinates for particular styles are became a bit harder: there are not anymore [Light, Extended] coordinates but [LightSlightlyChangedOnWidthAxis, ExtendedSlghtlyChangedOnWeightAxis]. 
## Let's try an example
Two dimensional font has four masters: ThinCondensed, BlackCondensed, ThinExtended and BlackExtended.
Let's say that generated instance ThinCondensed sholud be wider, BlackCondensed a little bit lighter, ThinExtended darker, and BlackExtedned not so wide and lighter. But what with restof instances? Which coordinates will be for NarrowBold? We need to set values for Narrow style at Width axis, separate for Light and Black edge and values for Weight axis, separate for Condensed and Extended edges. For two dimensions it's easy: it's just a point, where lines cross.
![](./pictures/exp01.png)

Fore more than two dimensions it bacame a little more complicated. First, each axis has `2^(n-1)` edges, where `n` is equal to number of dimensions. Second, lines in more then two dimensions doesn't like to cross each other. Sometimes they do, but in most cases don't. But it's possible to find common point of each dimension hyperbolic paraboloids. So, this tool does.

![](./pictures/exp02.png)

## Usage
Input is json file:
```json
{
	"axes":[
		{
			"name":"weight",
			"designMinimum":0,
			"designMaximum":1000,
			"axisInstances":[
				{
				"name":"Book",
				"values": [250, 100]
				},
				{
				"name":"Normal",
				"values": [450, 300]
				},
				{
				"name":"Medium",
				"values": [600, 550]
				},
				{
				"name":"Bold",
				"values": [900, 950]
				}
			]

		},
		{
			"name":"width",
			"designMinimum":0,
			"designMaximum":1000,
			"axisInstances":[
				{
				"name":"Condensed",
				"values": [100, 50]
				},
				{
				"name":"Narrow",
				"values": [350, 300]
				},
				{
				"name":"Regular",
				"values": [650, 600]
				},
				{
				"name":"Wide",
				"values": [950, 950]
				}
			]
		}
	]
}
```
I think it is self-explaing. Except experimental parameter `distribution` which causes exponential disribution of styles. Only first and last values counts.

if you use commadline siply feed `instaces_calculator` by `somejson.json` file.
If you prefer UI, use `ShowMeInstances` app which is pretty experimental. But first prepare `json` in some editor. This app allwos you to change numbers, copy and delete parts of code, but has some limitations... (i.e you cannot add line. Why not?) 

__Important__: number of values in `axisInstance` must be equal `2^(dimensions - 1)`; 2 for 2-dimensional, 4 for 3-dimensional, 8 for 4-dimensional designspace.
#### Rendering of distributed, not distorted 2d designspace
![](./pictures/exp03.png)
#### Rendering of distributed, distorted 2d designspace
![](./pictures/exp03a.png)
#### Rendering of manually set 2d designspace
![](./pictures/exp03b.png)
#### Rendering of distorted 3d designspace
![](./pictures/exp04.png)
#### Rendering of distorted 4d designspace. 4th dimension is represented by white balls
![](./pictures/exp05.png)
#### Rendering of distorted 5d designspace. 4th dimension is represented by blue color and 5th dimension is represented brightness
![](./pictures/exp06.png)
#### Rendering of distorted 6d designspace. 4th dimension is represented by hue,  5th by saturation, 6th by brightness.
![](./pictures/exp07.png)


