<template>
  <v-carousel cycle height="500" hide-delimiter-background show-arrows-on-hover>
    <v-carousel-item v-for="(item, i) in images" :key="i" :src="item.image">
      <v-container class="fill-height" align="center" justify="center">
      <v-row >
        <v-col cols="12"
        sm="4">
        <v-btn href="/patients" tile x-large color="success">
        <v-icon>mdi-bed</v-icon>
          Patients &raquo;
        </v-btn>
        </v-col>
        <v-col cols="12"
        sm="4">
        <v-btn href="/analysis" tile x-large color="success">
        <v-icon>mdi-state-machine</v-icon>
          Analysis &raquo;
        </v-btn>
        </v-col>
        <v-col cols="12"
        sm="4">
        <v-btn href="/worker" tile x-large color="success">
        <v-icon>mdi-shield-account</v-icon>
          My Account &raquo;
        </v-btn>
        </v-col>
      </v-row>
      </v-container>
    </v-carousel-item>
  </v-carousel>
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
      ],
      info,
    };
  },
};
</script>

