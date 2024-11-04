import SwiftUI
import AVKit

final class DContr: NSObject, AVAudioPlayerDelegate {
    
    let cdm = CDM()
    @AppStorage("lastWordForEveryone") var lastWordForEveryone = true
    @AppStorage("superWord") var superWord = true
    
    var commands: Array<Command> = []
    var currentPlayer: Command?
    var wordForNextRound: Word?
    
    var gameWords: Array<Word> = []
    var answeredWords: Array<(Word, Bool)> = []
    
    var complexity: Complexity = .medium
    var numberOfPointsToWin: Int = 25
    var roundTime = 30
    var takeAwayPoints = false
    
    var player: AVAudioPlayer?
    var playerAnswer: AVAudioPlayer?
    
    override init() {
        super.init()
        setMusic()
    }
    
    func load() {
        if let commands = try? cdm.fetchScore() {
            commands.forEach { si in
                var element = availableCommands.first(where: {$0.title == si.0})
                if element != nil {
                    availableCommands.remove(element!)
                    element?.totalScore += si.1
                    availableCommands.insert(element!)
                }
            }
        }
    }
    
    func setMusic() {
        guard let path = Bundle.main.path(forResource: "Main", ofType: "mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.currentTime = 0
            player?.volume = 0.4
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func setAnswerSound(_ isRight: Bool) {
        guard let path = Bundle.main.path(forResource: isRight ? "Right" : "Wrong", ofType: "mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        do {
            playerAnswer = try AVAudioPlayer(contentsOf: url)
            playerAnswer?.delegate = self
            playerAnswer?.currentTime = 0
            playerAnswer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveScore(_ commands: [Command]) {
        for i in 0..<commands.count {
            var element = availableCommands.first(where: {$0.title == commands[i].title})
            if element != nil {
                availableCommands.remove(element!)
                element?.totalScore += commands[i].score
                availableCommands.insert(element!)
            }
        }
        cdm.saveOrEditScore(availableCommands)
    }
    
    var categories: Array<Category> = [
        Category(title: "Sport", image: "Sport", selected: false, wordsId: 0),
        Category(title: "Cartoons", image: "Cartoons", selected: false, wordsId: 1),
        Category(title: "Animals", image: "Animals", selected: false, wordsId: 2),
        Category(title: "Harry Potter", image: "HarryPotter", selected: false, wordsId: 3),
        Category(title: "Gaming", image: "Gaming", selected: false, wordsId: 4),
        Category(title: "Celebrities", image: "Celebrities", selected: false, wordsId: 5),
        Category(title: "Food", image: "Food", selected: false, wordsId: 6),
        Category(title: "Nature", image: "Nature", selected: false, wordsId: 7),
        Category(title: "Transportation", image: "Transportation", selected: false, wordsId: 8),
        Category(title: "All categories", image: "AllCategories", selected: false, wordsId: 9)
    ]
    
    var availableCommands: Set<Command> = [
        Command(title: "Cheese Ninjas", image: "CheeseNinjas", score: 0, totalScore: 0),
        Command(title: "Luck Cupcakes", image: "LuckCupcakes", score: 0, totalScore: 0),
        Command(title: "Space Beavers", image: "SpaceBeavers", score: 0, totalScore: 0),
        Command(title: "BBQ Knights", image: "BBQKnights", score: 0, totalScore: 0),
        Command(title: "Cucumber Yogis", image: "CucumberYogis", score: 0, totalScore: 0),
        Command(title: "Banana Samurai", image: "BananaSamurai", score: 0, totalScore: 0),
        Command(title: "Wind Hamsters", image: "WindHamsters", score: 0, totalScore: 0),
        Command(title: "Caramel Pirates", image: "CaramelPirates", score: 0, totalScore: 0),
        Command(title: "Hedgehogs in Sneakers", image: "HedgehogsinSneakers", score: 0, totalScore: 0)
    ]
    
    var words: Array<Words> = [
        Words(id: 0, 
              easy: 
                [
                "Soccer",
                "Basketball",
                "Volleyball",
                "Tennis",
                "Hockey",
                "Rugby",
                "Boxing",
                "Swimming",
                "Athletics",
                "Fencing",
                "Skateboarding",
                "Snowboarding",
                "Alpine skiing",
                "Parachuting",
                "Cycling",
                "Triathlon",
                "Karate",
                "Judo",
                "Taekwondo",
                "Wrestling",
                "Chess",
                "Billiards",
                "Darts",
                "Table tennis",
                "Sumo",
                "Cybersports",
                "Aerobics",
                "Yoga",
                "Fitness",
                "Crossfit",
                "Pilates",
                "Squash",
                "Running",
                "Walking",
                "Sport Walking",
                "Gym",
                "Rowing",
                "Fun Riding",
                "Rock Climbing",
                "Surfing",
                "Kitesurfing",
                "Roller skating",
                "Mountaineering",
                "Dancing"
                           ],
                     medium: [
                        "Breakdance",
                        "Modern dance",
                        "Ballet",
                        "Choreography",
                        "Futsal",
                        "Beach volleyball",
                        "Golf",
                        "Motor sports",
                        "Motorcycling",
                        "Karting",
                        "Water Polo",
                        "Rugby Sevens",
                        "Freestyle",
                        "Kettlebell lifting",
                        "Paragliding",
                        "Canoeing",
                        "Windsurfing",
                        "Short track",
                        "Figure skating",
                        "Speed Skating",
                        "Gymnastics",
                        "High jumping",
                        "Skydiving",
                        "Ski jumping",
                        "Weightlifting",
                        "Long Jump",
                        "Javelin",
                        "Discus throw",
                        "Tennis ball",
                        "Soccer ball",
                        "Skis",
                        "Snowboard",
                        "Sneakers",
                        "Treadmills",
                        "Exercise equipment",
                        "Equipment",
                        "Exercise",
                        "Stretching"
                     ],
                     hard: [
                        "Cardio workout",
                        "Strength training",
                        "Functional training",
                        "Competitions",
                        "Tournament",
                        "Championship",
                        "League",
                        "Cup",
                        "Medal",
                        "Prize",
                        "Diploma",
                        "Coach",
                        "Athlete",
                        "Team",
                        "Composition",
                        "Ground",
                        "Swimming pool",
                        "Ice arena",
                        "Sports hall",
                        "Training",
                        "Warm-up",
                        "Result",
                        "Record",
                        "Strategy",
                        "Tactics",
                        "Technique",
                        "Level",
                        "Rewarding",
                        "Charity match"
                     ]),
        Words(id: 1, 
              easy: [
            "Cartoon",
            "Puppy",
            "Friendship",
            "Fairy tale",
            "Wizard",
            "Princess",
            "Villain",
            "Hero",
            "Dragon",
            "Castle",
            "Park",
            "Flying carpet",
            "Unicorn",
            "Robot",
            "Space",
            "Island",
            "School",
            "Labyrinth",
            "Thief",
            "City",
            "Home",
            "Sunny Day",
            "Rocket",
            "Journey",
            "Pirate",
            "Treasure",
            "Friends",
            "Guide",
            "Rescue",
            "Morning",
            "Winter",
            "Summer",
            "Smile"
         ],
         medium: [
            "Series",
            "Episode",
            "Story",
            "Dubbing",
            "Voiceover",
            "Animation",
            "Script",
            "Special Effects",
            "Director",
            "Artist",
            "Producer",
            "Foreshortening",
            "Scene",
            "Plan",
            "Camera",
            "Montage",
            "Dynamics",
            "Dialogue",
            "Frame",
            "Studio",
            "Screensaver",
            "Finale",
            "Operator",
            "Scenery",
            "Background",
            "Titles",
            "Music",
            "Spin-off",
            "Video montage",
            "Remake",
            "Art style",
            "Cinematography",
            "Fantasy",
            "Adventure",
            "Heroic",
            "Transformation",
            "Pilot"
         ],
         hard: [
            "Rotoscopy",
            "Anthropomorphism",
            "Polyscreen",
            "Metamorphosis",
            "Pixelization",
            "Compositing",
            "Photorealism",
            "Story arc",
            "Protagonist",
            "Antagonist",
            "Lipsync",
            "Decoding",
            "Characterization",
            "Chronology",
            "Animatics",
            "Stop-motion",
            "Branding",
            "Hyperbolization",
            "Phoneme synchronization",
            "Sketch animation",
            "Grotesque",
            "Symbolism",
            "Colorism",
            "Contrajour",
            "Key pose",
            "Parallax",
            "Background animation",
            "Avant-garde animation",
            "Reshaping",
            "Montage splicing",
            "Temporal",
            "Transition scene",
            "Pre-production",
            "Post-production",
            "Character Design",
            "Philosophical Undertones",
            "Line editing",
            "Tracing",
            "Vector graphics",
            "Movie effect",
            "Virtual camera",
            "Phantom Lines",
            "Mocap",
            "Non-linear narration",
            "Frame fluidity",
            "Conflict initiation",
            "Flash animation",
            "Parallelism"
         ]),
        Words(id: 2, 
              easy: [
            "Lion",
            "Tiger",
            "Zebra",
            "Elephant",
            "Cheetah",
            "Koala",
            "Panda",
            "Kangaroo",
            "Rhinoceros",
            "Leopard",
            "Monkey",
            "Jaguar",
            "Camel",
            "Crocodile",
            "Hippopotamus",
            "Jackal",
            "Lemur",
            "Chameleon",
            "Parrot",
            "Dolphin",
            "Shark",
            "Pelican",
            "Elk",
            "Boar",
            "Bear",
            "Badger",
            "Raccoon",
            "Lynx",
            "Meerkat",
            "Fox",
            "Swan",
            "Owl",
            "Ostrich",
            "Scat",
            "Antelope",
            "Skunk",
            "Coyote",
            "Buffalo",
            "Iguana"
         ],
         medium: [
            "Cat",
            "Dog",
            "Cow",
            "Horse",
            "Chicken",
            "Duck",
            "Rooster",
            "Goat",
            "Sheep",
            "Fish",
            "Rabbit",
            "Pig",
            "Hippo",
            "Bull",
            "Wolf",
            "Toad",
            "Penguin",
            "Hare",
            "Squirrel",
            "Hedgehog",
            "Frog",
            "Eagle",
            "Seagull",
            "Mole",
            "Goose",
            "Sparrow",
            "Peacock",
            "Turtle",
            "Stork",
            "Crow",
            "Giraffe",
            "Ant",
            "Bee",
            "Dragonfly",
            "Spider",
            "Mosquito",
            "Snail",
            "Grasshopper",
            "snake"
         ],
         hard: [
            "Oryx",
            "Dugong",
            "Ocelot",
            "Aye-aye",
            "Narwhal",
            "Axolotl",
            "Capybara",
            "Quokka",
            "Binturong",
            "Wombat",
            "Gaur",
            "Kiwi (bird)",
            "Galago",
            "Kasuar",
            "Mongoose",
            "Tapir",
            "Koipu",
            "Paca",
            "Pakarana",
            "Kulan",
            "Fossa",
            "Wihuhol",
            "Tuatara",
            "Caracal",
            "Jairan",
            "Vizcacha",
            "Pangolin",
            "Echidna",
            "Harpy (bird)",
            "Cob",
            "Toucan",
            "Bustard",
            "Crax",
            "Civet",
            "Kakapo",
            "Flamingo",
            "Coati",
            "Marginalis",
            "Capuchin",
            "Candelabra (coral)",
            "Irbis",
            "Guanaco",
            "Saola",
            "Psittacosaurus"
         ]),
        Words(id: 3, 
              easy: [
            "Harry Potter",
            "Hermione",
            "Ron",
            "Hogwarts",
            "Magic",
            "Wizardry",
            "Spell",
            "Book",
            "Tale",
            "Magician",
            "Cauldron",
            "Professor",
            "Headmaster",
            "Cloak",
            "Hat",
            "Voldemort",
            "Evil",
            "Good",
            "Mr.",
            "Ms.",
            "Store",
            "Half-orc",
            "Creature",
            "Flying",
            "Carpet",
            "Night",
            "Quill",
            "Money",
            "Thing",
            "Seal",
            "Child",
            "Flash drive",
            "Suitcase",
            "Backpack",
            "Bed",
            "Table",
            "Light bulb",
            "Wing",
            "Suit",
            "Helmet",
            "Body",
            "Academy",
            "Goblin",
            "Paperclip",
            "Whip",
            "Sound",
         ],
         medium: [
            "Dumbledore",
            "Snape",
            "Slytherin",
            "Gryffindor",
            "Ravenclaw",
            "Puffendui",
            "Hedwig",
            "Lord",
            "Serfs",
            "Potion",
            "Deathly Hallows",
            "Portal",
            "Phoenix",
            "Boggart",
            "Curveballs",
            "Cobra",
            "Marauder's Map",
            "Gringotts",
            "Magic Wands",
            "Lunatic",
            "Laurel Wreath",
            "Witch",
            "Course",
            "Testing",
            "Happiness",
            "Collection",
            "Snapshot",
            "Spellbook",
            "Inquisitor",
            "Artifact",
            "Closet",
            "Enchantment",
            "Guards",
            "Crack",
            "Wolfman",
            "Golden Snitch",
            "Witcher",
            "Head",
            "Christmas",
            "Slippers",
            "Muggle",
            "Turning Point",
            "Humanity",
            "Trips",
            "Troll",
            "Snowflakes",
            "Briefcase",
            "Harpy",
            "Meeting",
            "Cloth",
            "Mr. Bureau",
         ],
         hard: [
            "Hermione Granger",
            "Ron Weasley",
            "Albus Dumbledore",
            "Severus Snape",
            "Remus Lupin",
            "Neville Longbourn",
            "Draco Malfoy",
            "Sirius Black",
            "Lily Potter",
            "James Potter",
            "Minerva McGonagall",
            "Filius Flitwick",
            "Rubeus Hagrid",
            "Rita Skeeter",
            "Gregory Goyle",
            "Vincent Crabbe",
            "Pettigrew",
            "Bellatrix Lestrange",
            "Narcissa Malfoy",
            "Lucius Malfoy",
            "Tom Riddle",
            "Roger Davies",
            "Dean Thomas",
            "Slaven Malfoy",
            "Parvati Patil",
            "Padma Patil",
            "Fred Weasley",
            "George Weasley",
            "Molly Weasley",
            "Arthur Weasley",
            "Charlie Weasley",
            "Percy Weasley",
            "Ginevra Weasley",
            "Luna Lovegood",
            "Xenophilius Lovegood",
            "Herbert Watch",
            "Cedric Diggory",
            "Ollivander",
            "Professor Sprout",
            "Professor Sinistra",
            "Professor Slackhorn",
            "Tonks",
            "Mungo Bondi",
            "Kreacher",
            "Fenrir Greyback",
            "Godric Gryffindor",
            "Helga Hufflepuff",
            "Ravena Ravenclaw",
            "Salazar Slytherin",
            "Ginny Weasley",
            "Albus Potter",
            "Scorpius Malfoy",
            "Astoria Granger",
            "Randall Slaper",
            "Nicholas Flamel",
            "Granger",
            "Quirrell",
            "George Longbortom",
            "Anne Longbortom",
            "Susanna Tonks",
            "William Powell",
            "Edward Seaton",
            "Barty Crouch",
            "Lorna James",
            "Amelia Bones",
            "Penelope"
         ]),
        Words(id: 4, 
              easy: [
                 "Game console",
                 "Computer",
                 "Keyboard",
                 "Mouse",
                 "Monitor",
                 "Gamepad",
                 "Pixels",
                 "Graphics",
                 "Picture",
                 "Task",
                 "Quest",
                 "Character",
                 "Saving",
                 "Loading",
                 "Game Menu",
                 "Settings",
                 "Game",
                 "Gameplay",
                 "Secrets",
                 "Secret Places",
                 "Bonus",
                 "Rating",
                 "Weapons",
                 "Armor",
                 "Map",
                 "World",
                 "Location",
                 "Mission",
                 "Bosses",
                 "Enemy",
                 "Friendly"
              ],
              medium: [
                 "Online",
                 "Player",
                 "Cooperative",
                 "PvP (Player vs. Player)",
                 "PvE (Player vs. Environment)",
                 "Boss",
                 "Walkthrough",
                 "Cheats",
                 "Hack",
                 "Leaders",
                 "Gamer",
                 "Dungeon",
                 "Secret",
                 "Final",
                 "Quests",
                 "Virtual Reality",
                 "Simulator",
                 "Platformer",
                 "RPG (Role Playing Game)",
                 "FPS (First Person Shooter)",
                 "CTS (Third Person Shooter)",
                 "Survival",
                 "Race",
                 "Sport",
                 "Arcade",
                 "Puzzle",
                 "Rank",
                 "Panel"
              ],
              hard: [
                 "Buildings",
                 "Zones",
                 "Cryptocurrency",
                 "Resources",
                 "Energy",
                 "Health",
                 "Points",
                 "Unlock",
                 "Time Events",
                 "Keys",
                 "Models",
                 "Skins",
                 "Campaign",
                 "Multiplayer",
                 "Victories",
                 "Bouts",
                 "Achievements",
                 "Challenge",
                 "Fighters",
                 "Virtual",
                 "Mode",
                 "Riddles",
                 "Heroes",
                 "Buy",
                 "Sale",
                 "Market",
                 "Inventory",
                 "Cartridge",
                 "Upgrade",
                 "Group",
                 "Reactions",
                 "Stream",
              ]),
        Words(id: 5,
              easy: [
                 "Brad Pitt",
                 "Jennifer Aniston",
                 "Tom Hanks",
                 "Angelina Jolie",
                 "Leonardo DiCaprio",
                 "Julia Roberts",
                 "Robert Downey Jr.",
                 "Meryl Streep",
                 "Will Smith",
                 "Sandra Bullock",
                 "Ryan Reynolds",
                 "Scarlett Johansson",
                 "Johnny Depp",
                 "Chris Hemsworth",
                 "Natalie Portman",
                 "Jason Momoa",
                 "Jennifer Lawrence",
                 "Emma Watson",
                 "Margot Robbie",
                 "Hugh Jackman",
                 "Cameron Diaz",
                 "Katy Perry",
                 "Taylor Swift",
                 "Ed Sheeran",
                 "Beyoncé",
                 "Lady Gaga",
                 "Justin Timberlake",
                 "Ariana Grande",
                 "Stevie Wonder",
                 "Bruce Willis",
                 "Jim Carrey",
                 "John Legend",
                 "Rihanna",
                 "Nicki Minaj",
                 "Chris Evans",
                 "Zendaya",
                 "Dwayne Johnson",
                 "Neil Patrick Harris",
                 "Jim Parsons",
                 "Amy Adams",
                 "Adam Levine",
                 "Steve Carell",
                 "Joan Rivers",
                 "Benedict Cumberbatch",
                 "Gal Gadot",
                 "Richard Gere"
              ],
              medium: [
                 "Steven Spielberg",
                 "Hugh Laurie",
                 "Nicole Kidman",
                 "James Franco",
                 "Keira Knightley",
                 "Jake Gyllenhaal",
                 "Judi Dench",
                 "Ryan Gosling",
                 "Charlie Theron",
                 "Samuel L. Jackson",
                 "Penelope Cruz",
                 "Cate Blanchett",
                 "Matt Damon",
                 "James McAvoy",
                 "Kate Beckinsale",
                 "Emily Blunt",
                 "John Cena",
                 "Julianne Moore",
                 "Tom Hiddleston",
                 "Jude Law",
                 "Chris Pratt",
                 "Greta Gerwig",
                 "Nicolas Cage",
                 "John C. Reilly",
                 "Charlize Theron",
                 "Patti Smith",
                 "Sean Penn",
                 "Selma Hayek",
                 "Benicio Del Toro",
                 "Olivia Wilde",
                 "Chris Rock",
                 "John Kravitz",
                 "Reese Witherspoon",
                 "Jennifer Gardner",
                 "Josh Hutcherson",
                 "Ben Stiller",
                 "Zoe Saldana",
                 "Damian Bichir",
                 "Mila Kunis",
                 "Elissa Milano",
                 "Daniel Radcliffe",
                 "Jodie Foster",
                 "Helen Hunt",
                 "Michelle Williams",
                 "Jack Nicholson"
              ],
              hard: [
                 "Alec Baldwin",
                 "Daniel Day-Lewis",
                 "Javier Bardem",
                 "Rami Malek",
                 "Numphy Rapace",
                 "Christoph Waltz",
                 "Rachel Weisz",
                 "Edward Norton",
                 "Kristen Stewart",
                 "Marion Cotillard",
                 "Helen Mirren",
                 "Juliette Binoche",
                 "Sally Hawkins",
                 "Stephen Young",
                 "Mahershala Ali",
                 "Ruth Nega",
                 "Winona Ryder",
                 "Tilda Swinton",
                 "Simon Pegg",
                 "Naomi Watts",
                 "Oscar Isaac",
                 "Eddie Redmayne",
                 "Patricia Clarkson",
                 "Idris Elba",
                 "Giovanni Ribisi",
                 "Susan Sarandon",
                 "Jon Hamm",
                 "Olivia Colman",
                 "Kate Winslet",
                 "Hugo Weaving",
                 "Joan Allen",
                 "Martin Freeman",
                 "David Oyelowo",
                 "Elizabeth Debicki",
                 "Gwyneth Paltrow",
                 "Gennifer Lawrence",
                 "Greg Kinnear",
                 "Jeff Bridges",
                 "Toma Steers",
                 "Jason Statham",
                 "Anya Taylor-Joy",
                 "Ginnifer Gray",
                 "Christopher Lambert",
                 "Stephen Fry",
                 "Charlotte Rampling",
                 "Xavier Dolan",
                 "Robert Sheehan",
                 "Liev Schreiber"
              ]),
        Words(id: 6,
              easy: [
                 "Bread",
                 "Butter",
                 "Milk",
                 "Cheese",
                 "Egg",
                 "Meat",
                 "Beef",
                 "Pork",
                 "Vegetables",
                 "Potatoes",
                 "Carrots",
                 "Tomato",
                 "Cucumber",
                 "Onion",
                 "Garlic",
                 "Pepper",
                 "Cabbage",
                 "Broccoli",
                 "Cauliflower",
                 "Lettuce",
                 "Apple",
                 "Banana",
                 "Orange",
                 "Pear",
                 "Kiwi",
                 "Grape",
                 "Watermelon",
                 "Melon",
                 "Berry",
                 "Honey",
                 "Yogurt",
                 "Sour cream",
                 "Porridge",
                 "Macaroni",
                 "Rice",
                 "Soup",
                 "Borscht",
                 "Pancakes",
                 "Pizza",
                 "Hot dogs",
                 "Chips",
                 "Popcorn",
                 "Cupcake",
                 "Pie",
                 "Cookies",
                 "Chocolate",
                 "Candy",
                 "Ice cream",
                 "Compote",
                 "Tea",
                 "Coffee",
                 "Juice",
                 "Mineral water",
                 "Cottage cheese",
                 "Sausage",
                 "Fish cutlets",
                 "Cutlets",
                 "Omelette",
                 "Salad",
                 "Buckwheat",
                 "Waffles",
                 "Sushi",
                 "Roll",
                 "Cake"
              ],
              medium: [
                 "Avocado",
                 "Salmon",
                 "Turkey",
                 "Squid",
                 "Tuna",
                 "Crab",
                 "Pate",
                 "Baked ham",
                 "Cheddar",
                 "Feta",
                 "Mascarpone",
                 "Tortilla",
                 "Burrito",
                 "Quesadilla",
                 "Tapas",
                 "Guacamole",
                 "Chicken wings",
                 "Ribs",
                 "Croquettes",
                 "Quiche",
                 "Mashed Potato Soup",
                 "Cream soup",
                 "Salami",
                 "Pasta",
                 "Spaghetti",
                 "Risotto",
                 "Fettuccini",
                 "Lasagna",
                 "Chicken steak",
                 "Chili",
                 "Greek salad",
                 "Tabbouleh",
                 "Hummus",
                 "Lokshina",
                 "Dumplings",
                 "Vareniki",
                 "Kebab",
                 "Shashlyk",
                 "Paprikash",
                 "Casserole",
                 "Stew",
                 "Kharcho soup",
                 "Buckwheat porridge",
                 "Couscous",
                 "Bulgur",
                 "Caprese",
                 "Sashimi",
                 "Cheesecakes",
                 "Pudding",
                 "Mousse",
                 "Muffins",
                 "Tart",
                 "Profiteroles",
                 "Macarons",
                 "Polenta",
                 "Falafel",
                 "Chicken cutlets",
                 "Vegetable stew",
                 "Frittata",
                 "Escalope",
                 "Burger",
                 "Dip",
                 "Herring under fur coat",
                 "Teppanyaki",
                 "Yogurt Sauce",
                 "Fondue",
                 "Celery",
                 "Caramel"
              ],
              hard: [
                 "Duck confit",
                 "Chestnut cream",
                 "Beef carpaccio",
                 "Foie gras",
                 "Salmon Tartare",
                 "Ciabatta",
                 "Focaccia",
                 "Seafood Casserole",
                 "Vegetarian stew",
                 "Crème brûlée",
                 "Truffle oil",
                 "Spicy tagine",
                 "Arancini",
                 "Ratatouille",
                 "Cannelloni",
                 "Baba ganoush",
                 "Chicken liver pate",
                 "Calzone",
                 "Stuffed zucchini",
                 "Gazpacho",
                 "Miso soup",
                 "Lasagna Alfredo",
                 "Risotto with saffron",
                 "Chicken Paprikash",
                 "Burrata",
                 "Beef Stroganoff",
                 "Lamb kebab",
                 "Escargot",
                 "Crepes",
                 "Soufflé",
                 "Trout with almond sauce",
                 "Chia pudding",
                 "Fennel with olive oil",
                 "Agnus a la grill",
                 "Grilled sepia",
                 "Tom Yum",
                 "Strudel",
                 "Stuffed peppers",
                 "Korean cucumbers",
                 "Ricotta pie",
                 "Brioche",
                 "Stuffed mushrooms",
                 "Onion soup",
                 "Truffle risotto",
                 "Greek moussaka",
                 "Ceviche",
                 "Mussels in white wine",
                 "Cherry pie",
                 "Tortilla de patatas",
                 "Caviar pancakes",
                 "Tiramisu",
                 "Flanders steak",
                 "Champagne sauce",
                 "Sesame oil",
                 "Beef Tartare",
                 "Suluguni",
                 "Agnestones",
                 "Chocolate fondant",
                 "Quinoa salad",
                 "Baked eggplants",
                 "Enchiladas",
                 "Funchoza",
                 "Seaweed soup",
                 "Shrimp teriyaki",
                 "Kulebyaka",
                 "Cumin",
                 "Indian curry",
                 "Seafood salad",
                 "Cake with mascarpone cream",
                 "Lasagna with mushrooms",
                 "White Mushroom Soup",
                 "Avocado and mango salad"
              ]),
        Words(id: 7,
              easy: [
                 "Forest",
                 "Mountain",
                 "River",
                 "Lake",
                 "Sea",
                 "Ocean",
                 "Beach",
                 "Sun",
                 "Moon",
                 "Star",
                 "Thunderstorm",
                 "Rain",
                 "Snow",
                 "Fog",
                 "Wind",
                 "Grass",
                 "Flower",
                 "Tree",
                 "Bush",
                 "Leaf",
                 "Root",
                 "Bird",
                 "Beetle",
                 "Butterfly",
                 "Gnat",
                 "Deer",
                 "Lightning",
                 "Wave",
                 "Sand",
                 "Pebble",
                 "Stone",
                 "Rock"
              ],
              medium: [
                 "Cave",
                 "Spring",
                 "Pond",
                 "Salt Lake",
                 "Meadow",
                 "Valley",
                 "Glade",
                 "Birdhouse",
                 "Nest",
                 "Barrow",
                 "Path",
                 "Bridge",
                 "Waterfall",
                 "Garden",
                 "Orchard",
                 "Front garden",
                 "Greenhouse",
                 "Noise",
                 "Tranquility",
                 "Landscape",
                 "Nature",
                 "Ecosystem",
                 "Climate",
                 "Temperature",
                 "Humidity",
                 "Shrub",
                 "Shoemaker",
                 "Shallow",
                 "Shore",
                 "Flood",
                 "Forest glade",
                 "Moss",
                 "Mushrooms",
                 "Berries",
                 "Nuts",
                 "Dewberry"
              ],
              hard: [
                 "Rosehip",
                 "Lavender",
                 "Petunia",
                 "Chamomile",
                 "Cornflower",
                 "Tulip",
                 "Iris",
                 "Gladiolus",
                 "Kalina",
                 "Rowan",
                 "Dandelion",
                 "Clover",
                 "Melissa",
                 "Camellia",
                 "Jasmine",
                 "Fern",
                 "Reseda",
                 "Cherada",
                 "Nettle",
                 "Laurel leaf",
                 "Laurel",
                 "Pistachio",
                 "Orchid",
                 "Amaranth",
                 "Lotus",
                 "Calendula",
                 "Lily of the valley",
                 "Sparrowberry",
                 "Geranium",
                 "Fuchsia",
                 "Edelweiss",
                 "Peonies",
                 "Lily",
                 "Saffron",
                 "Elderberry",
                 "Lilac",
                 "Calypso",
                 "Pastel",
                 "Poplar"
              ]),
        Words(id: 8,
              easy: [
                 "Automobile",
                 "Train",
                 "Airplane",
                 "Bus",
                 "Trolleybus",
                 "Streetcar",
                 "Bicycle",
                 "Motorcycle",
                 "Ship",
                 "Boat",
                 "Yacht",
                 "Submarine",
                 "High-speed train",
                 "Rickshaw",
                 "Truck",
                 "Car",
                 "Convertible",
                 "SUV",
                 "Van",
                 "Sedan",
                 "Crossover",
                 "Minibus",
                 "Electric scooter",
                 "Racing car",
                 "Tank",
                 "Scooter",
                 "Transformer",
                 "Platform",
                 "Railroad train",
                 "Hydrocycle"
              ],
              medium: [
                 "Tourist bus",
                 "Passenger airplane",
                 "Biplane",
                 "Helicopter",
                 "Agricultural transport",
                 "Freight train",
                 "Subway",
                 "Aeroexpress",
                 "Modular train",
                 "Sea tugboat",
                 "Tourist vessel",
                 "River transport",
                 "Shuttle",
                 "Ultralighter",
                 "Bomber",
                 "Jeep",
                 "Warp",
                 "Stunt Car",
                 "Jet Engine",
                 "Road bike",
                 "Racing Motorcycle",
                 "Air Mail",
                 "Trailer",
                 "Electric car",
                 "Trolleybus route",
                 "Agricultural combine",
                 "Ball bearing",
                 "Elevator",
                 "Skateboard"
              ],
              hard: [
                 "Passenger transportation",
                 "Passenger boat",
                 "Balloon",
                 "Trolleybus station",
                 "Metroexpress",
                 "Tandem",
                 "Jet airplane",
                 "Shipping container",
                 "Ferry",
                 "Flight Controller",
                 "Cargo ship",
                 "Storm boat",
                 "Landing gear",
                 "Rail vehicle",
                 "Motorcycle with sidecar",
                 "Sky transport",
                 "Rolling Car",
                 "Cargo van",
                 "Road train",
                 "Tanker",
                 "Electric bus",
                 "Speedboat",
                 "Tugboat",
                 "Underground subway",
                 "Savelievsky train",
                 "Truck Crane",
                 "Manipulator crane",
                 "Suburban train",
                 "Light rail transportation",
                 "River steamer",
                 "Two-seater airplane",
                 "Recreational boat",
                 "Bus station",
                 "Mechanical transportation"
              ]),
        Words(id: 9, easy: [], medium: [], hard: [])
    ]
}
