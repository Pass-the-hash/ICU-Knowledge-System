<template>
  <v-form
      ref="form"
      @submit.prevent="submit"
  >
    <v-card
        flex
    >
      <v-dialog
          v-model="dialog"
          width="500"
      >

        <v-card>
          <v-card-title class="text-h5 lighten-2 justify-center">
            Τα στοιχεία προστέθηκαν!
          </v-card-title>

<!--          <v-card-text>
            Τα στοιχεία προστέθηκαν.
          </v-card-text>-->

<!--          <v-divider></v-divider>-->

          <v-card-actions class="justify-center">
<!--            <v-spacer></v-spacer>-->
            <v-btn
                color="success"
                text
                @click="disposeDialog"
            >
              Ολοκληρωση
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

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
              :rules="rules.PLT"
          ></v-text-field>
          <v-text-field
              v-model.number="information.FiO2"
              type="number"
              color="green"
              label="Ποσοστό παρεχόμενου οξυγόνου"
              min="21"
              max="262"

              required
              :rules="rules.FiO2"
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
              :rules="rules.MAP"
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
              :rules="rules.CR"
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
              :rules="rules.BIL"
          ></v-text-field>
          <v-text-field
              v-model.number="information.PaO2"
              type="number"
              color="green"
              label="Μερική πίεση οξυγόνου"
              min="2"
              max="595"

              required
              :rules="rules.PaO2"
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
    headers:Object,
  },
  data: () => ({
    information:{},
    rules: {
      rules: [v => (v || '').length > 0 || 'Απαιτούμενο πεδίο'],
      /*numeric: [
          // val => (val || '').length > 0 || 'Απαιτούμενο πεδίο',
          v => (v || '') > 0 || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'
      ],*/
      CR: [(v) => !!v, (v) => (v && v >= 0.15 && v <= 15.1)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'],
      BIL: [(v) => !!v, (v) => (v && v >= 0.1 && v <= 22.5)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'],
      PLT: [(v) => !!v, (v) => (v && v >= 3 && v <= 726)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'],
      MAP: [(v) => !!v, (v) => (v && v >= 9 && v <= 138)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'],
      FiO2: [(v) => !!v, (v) => (v && v >= 21 && v <= 262)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'],
      PaO2: [(v) => !!v, (v) => (v && v >= 2 && v <= 595)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων'],
    },
    dialog: false,
  }),
  methods: {
    submit () {
      axios
        .patch("http://localhost:3000/analysis/" + this.$route.params.AMKA, this.information, this.headers)
          .then(res => {
        console.log(res);
      }).catch(err => {
        console.log(err.response);
      }).then(() => {
        this.dialog = true
        // this.$store.commit('EnableDialog')
      });
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
    },
    disposeDialog() {
      this.dialog = false
      this.$router.go(0)
    }
  },
}
</script>

<style scoped>

</style>