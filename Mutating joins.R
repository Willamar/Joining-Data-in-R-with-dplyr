
# Complete the code to join artists to bands
bands2 <- left_join(bands, artists, by = c("first", "last"))

# Examine the results
bands2

bands3 <- right_join(artists, bands, by = c("first", "last"))

# Check that bands3 is equal to bands2
setequal(bands2, bands3)

# Join albums to songs using inner_join()
inner_join(songs, albums, by = "album")

# Join bands to artists using full_join()
full_join(artists, bands, by = c("first", "last"))

# Find guitarists in bands dataset (don't change)
temp <- left_join(bands, artists, by = c("first", "last"))
temp <- filter(temp, instrument == "Guitar")
select(temp, first, last, band)

# Reproduce code above using pipes
bands %>% 
  left_join(artists, by = c("first", "last")) %>%
  filter(instrument == "Guitar") %>%
  select(first, last, band)

# Examine the contents of the goal dataset
goal

# Create goal2 using full_join() and inner_join() 
goal2 <- artists %>% full_join(bands, by = c("first", "last")) %>%
  inner_join(songs, by = c("first", "last"))

# Check that goal and goal2 are the same
setequal(goal, goal2)

# Create one table that combines all information
artists %>%
  full_join(bands, by = c("first", "last")) %>%
  full_join(songs, by = c("first", "last")) %>%
  full_join(albums, by = c("album", "band"))

# View the output of semi_join()
artists %>% 
  semi_join(songs, by = c("first", "last"))

# Create the same result
artists %>% 
  right_join(songs, by = c("first", "last")) %>% 
  filter(!is.na(instrument)) %>% 
  select(first, last, instrument)

albums %>% 
  # Collect the albums made by a band
  semi_join(bands, by= "band") %>% 
  # Count the albums made by a band
  nrow()

# Return rows of artists that don't have bands info
artists %>% 
  anti_join(bands, by = c("first", "last"))

# Check whether album names in labels are mis-entered
labels %>% 
  anti_join(albums, by = "album")

# Determine which key joins labels and songs
labels
songs

# Check your understanding
songs %>% 
  # Find the rows of songs that match a row in labels
  inner_join(labels, by = "album") %>% 
  # Number of matches between labels and songs
  nrow()

aerosmith %>% 
  # Create the new dataset using a set operation
  union(greatest_hits, by = "song")%>% 
  # Count the total number of songs
  nrow()

# Create the new dataset using a set operation
aerosmith %>% 
  intersect(greatest_hits, by = "song")

# Select the song names from live
live_songs <- live %>% select(song)

# Select the song names from greatest_hits
greatest_songs <- greatest_hits %>% select(song)

# Create the new dataset using a set operation
live_songs %>% 
  setdiff(greatest_songs, by = "song")

# Select songs from live and greatest_hits
live_songs <- select(live, song)
greatest_songs <- select(greatest_hits, song)


# Find songs in at least one of live_songs and greatest_songs
all_songs <- union(live_songs, greatest_songs, by="song")

# Find songs in both 
common_songs <- intersect(intersect(all_songs, live_songs, by = "song"), greatest_songs, by = "song")

# Find songs that only exist in one dataset
setdiff(all_songs, common_songs, by = "song")

# Check if same order: definitive and complete
identical(definitive, complete)

# Check if any order: definitive and complete
setequal(definitive, complete)

# Songs in definitive but not complete
setdiff(definitive, complete, by = "song")


# Songs in complete but not definitive
setdiff(complete, definitive, by="song")


# Return songs in definitive that are not in complete
definitive %>% 
  setdiff(complete, by = "song")

# Return songs in complete that are not in definitive
complete %>% 
  setdiff(definitive, by="song")

# Get union of complete and soundtrack
complete_and_soundtrack <- union(complete, soundtrack, by = "song")


# Check if same, including order: definitive and union of complete and soundtrack
complete_and_soundtrack %>%
  identical(definitive)


# Check if same, rows in any order: definitive and union of complete and soundtrack
complete_and_soundtrack %>%
  setequal(definitive)
