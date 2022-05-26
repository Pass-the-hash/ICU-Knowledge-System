<template>
  <div>
    <v-card>
      <v-card-text>
        <h2 align="center" justify="center" class="headline "> Καλωσήρθατε στην πλατφόρμα για την παρακολούθηση διασωληνωμένων ασθενών!</h2>
        <br>
        <h3 align="center" class="font-weight-light "> Εδώ μπορείτε να κάνετε καταγραφή και παρακολούθηση της πορείας της υγείας των ασθενών, καθώς και να επεξεργαστείτε τα στοιχεία του λογαριασμού σας.</h3>
      </v-card-text>
    </v-card>
    <br>
    <v-carousel
      cycle
      height="500"
      hide-delimiter-background
      show-arrows-on-hover
      :show-arrows="false"
    >
      <v-carousel-item v-for="(item, i) in images" :key="i" :src="item.image">
      </v-carousel-item>
    </v-carousel>
    <br>
    <v-row>
      <v-col cols="12" sm="6">
        <v-card
          class="mx-auto"
        >
          <v-img
            src="@/assets/images/3.jpg"
            height="200px"
          ></v-img>

          <v-card-title>
            Προβολή Αθενών
          </v-card-title>

          <v-card-subtitle>
            Δείτε τους καταχωρημένους ασθενείς τα στατιτστικά και τις αναλύσεις για αυτούς.
          </v-card-subtitle>

          <v-card-actions>
            <v-btn
              color="success"
              text
              to="/patients"
            >
              προβολη
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
      <v-col cols="12" sm="6">
        <v-card
          class="mx-auto"
        >
          <v-img
            src="https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
            height="200px"
          ></v-img>

          <v-card-title>
            Προβολή Προφίλ
          </v-card-title>

          <v-card-subtitle>
            Δείτε το προφίλ σας και επεξεργαστείτε το.
            <br><br>
          </v-card-subtitle>

          <v-card-actions>
            <v-btn
              color="success"
              text
              to="/worker"
            >
              προβολη
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
// noinspection JSUnusedGlobalSymbols
export default {
  name: "Main",
  data() {
    let info;
    return {
      images: [
        { image: require("@/assets/images/1.jpg") },
        { image: require("@/assets/images/2.jpg") },
        { image: require("@/assets/images/3.jpg") }
      ],
      info,
    };
  },
};
</script>

<style scoped>
.h1, .h2{
  display: flex;
  align-items: center;
  justify-content: center;
  height: 10vh;
}
</style>