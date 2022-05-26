<template>
  <v-form
      ref="form"
      @submit.prevent="submit"

  >
    <v-card
        flex
    >
      <v-toolbar flat color="success--text ">
          <v-icon color="success">mdi-account-details</v-icon>
          <v-toolbar-title class="font-weight-light">
            Τωρινά δεδομένα ασθενούς
          </v-toolbar-title>
        </v-toolbar>
      <v-card-text>
        <v-container>
      <v-row>
        <v-col
            cols="12"
            sm="6"
        >

          <v-text-field
              v-model.number="information.PLT"
              type="number"
              color="green"
              label="Αιμοπετάλια"
              required
              min="3"
              max="726"
              @keypress="isNumber($event)"
              :rules="rules.numeric"
          ></v-text-field>
          <v-text-field
              v-model.number="information.FiO2"
              type="number"
              color="green"
              label="Ποσοστό παρεχόμενου οξυγόνου"
              min="21"
              max="262"

              required
              :rules="rules.numeric"
          ></v-text-field>
          <v-text-field
              v-model.number="information.MAP"
              type="number"
              color="green"
              label="Αρτηριακή πίεση"

              required
              min="9"
              max="138"
              @keypress="isNumber($event)"
              :rules="rules.numeric"
          ></v-text-field>
        </v-col>
        <v-col
            cols="12"
            sm="6"
        >
          <v-text-field
              v-model.number="information.CR"
              type="number"
              color="green"
              label="Κρεατινίνη"
              min="0.15"
              max="15.1"

              required
              :rules="rules.numeric"
          ></v-text-field>
          <v-text-field
              v-model.number="information.BIL"
              type="number"
              color="green"
              label="Χολερυθρίνη"

              required
              @keypress="isNumber($event)"
              min="0.1"
              max="22.5"
              :rules="rules.numeric"
          ></v-text-field>
          <v-text-field
              v-model.number="information.PaO2"
              type="number"
              color="green"
              label="Μερική πίεση οξυγόνου"
              min="2"
              max="595"

              required
              :rules="rules.numeric"
          ></v-text-field>
        </v-col>
        <v-col
            cols="12"
            sm="6"
        >
        </v-col>
        <v-col
            cols="12"
            sm="12"
        >
          <v-slider
              v-model="information.UoP"
              color="success"
              label="Ημερήσια ούριση"
              min="1"
              max="3"
              thumb-label

          ></v-slider>
        </v-col>

      </v-row>
      <v-btn
          elevation="2"
          outlined
          color="success"
          type="submit"
      >
        Υποβολη
      </v-btn>
    </v-container>
    </v-card-text>

  </v-card>
  </v-form>
</template>

<script>
import axios from "axios";

export default {
  name: "Add",
  props: {
    headers:Object
  },
  data: () => ({
    information:{},
    rules: {
      rules: [val => (val || '').length > 0 || 'Απαιτούμενο πεδίο'],
      numeric: [
          // val => (val || '').length > 0 || 'Απαιτούμενο πεδίο',
          val => (val || '') > 0 || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'
      ]
    },
  }),
  methods: {
    submit () {
      axios
        .patch("http://localhost:3000/analysis/" + this.$route.params.AMKA, this.information, this.headers)
          .then(res => {
        console.log(res);
      }).catch(err => {
        console.log(err.response);
      }).then(() => this.$router.go(0));
          //.then(() => this.$router.go(0));
    },
    isNumber(evt) {
      evt = (evt) ? evt : window.event;
      var charCode = (evt.which) ? evt.which : evt.keyCode;
      if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode !== 46) {
        evt.preventDefault();
      } else {
        return true;
      }
    }
  },
}
</script>

<style scoped>

</style>