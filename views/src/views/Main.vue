<template>
  <div>
    <v-carousel
      cycle
      height="500"
      hide-delimiter-background
      show-arrows-on-hover
      :show-arrows="false"
    >
      <v-carousel-item v-for="(item, i) in images" :key="i" :src="item.image">
        <v-container class="fill-height" align="center" justify="center">
          <v-row>
            <v-col cols="12" sm="4">
              <v-btn href="/worker" tile x-large color="success">
                <v-icon>mdi-shield-account</v-icon>
                Προφιλ &raquo;
              </v-btn>
            </v-col>
            <v-col cols="12" sm="4">
              <v-btn href="/patients" tile x-large color="success">
                <v-icon>mdi-bed</v-icon>
                Ασθενεις &raquo;
              </v-btn>
            </v-col>
            <v-col cols="12" sm="4">
              <v-btn href="/construct" tile x-large color="success">
                <v-icon>mdi-help</v-icon>
                Σχετικα &raquo;
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-carousel-item>
    </v-carousel>
    <v-divider></v-divider>
    <div class="h1">
      <h1> Καλωσήρθατε στην πλατφόρμα για την παρακολούθηση διασωληνωμένων ασθενών!</h1>
    </div>
    <br>
      <div class="h2">
        <h2> Εδώ μπορείτε να κάνετε καταγραφή και παρακολούθηση της πορείας της υγείας των ασθενών, καθώς και να επεξεργαστείτε τα στοιχεία του λογαριασμού σας.</h2>
      </div>
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