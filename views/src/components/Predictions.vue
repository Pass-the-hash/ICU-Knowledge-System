<template>
  <v-container
        color="grey darken-2"
    >

    <h1> Ενδείξεις υποσυστήματος τεχνητής νοημοσύνης:</h1>
    <v-row>
      <v-col>
        <apexchart width="500" :options="mortality" :series="series1"></apexchart>
      </v-col>
      <v-col>
        <apexchart width="500" :options="vasopressors" :series="series2"></apexchart>
      </v-col>

    </v-row>
    <!-- <apexchart width="500" :options="options" :series="series"></apexchart>
      <apexchart width="500" :options="options" :series="series"></apexchart>-->

  </v-container>
</template>

<script>
import axios from "axios";

export default {
  name: "Predictions",
  props: {
    patient: {
      type: Object,
      required: true
    },
    headers: {},
  },
  data: () =>({
    mortality: {
      chart: {
        id: 'vuechart-example',
        foreColor: 'azure',
        height: 350,
        type: 'radialBar',
      },
    },
    vasopressors: {
      chart: {
        id: 'vuechart-example2',
        foreColor: 'azure',
        height: 350,
        type: 'radialBar',
      },
    },
    series1: [],
    series2: [],
    response: [],
  }),
  methods: {
    getPredictions() {
      axios
        .get("http://localhost:3000/analysis/" + this.patient.AMKA + "/prediction", this.headers)
        .then((response) => {
          this.response = response.data
        })
        .then(() => {
          this.updateChart()
          console.log(this.response)
        })
    },
    updateChart() {
      this.series1 = [this.response[0]]
      this.series2 = [this.response[1]]

      let color
      if (this.series1[0] < 30.0) color = '#de1037'
      else if (this.series1[0] < 60.0) color = '#f1b626'
      else color = '#38b726'

      this.mortality = {

        colors: [color],
        series: this.series1,
        plotOptions: {
          radialBar: {
            hollow: {
              size: 80,
            }
          },
        },
        labels: ['Ποσοστό επιβίωσης'],
      }
      this.vasopressors = {
        series: this.series2,
        // series: [{data: this.response[1]}],
        plotOptions: {
          radialBar: {
            hollow: {
              size: 80,
            }
          },
        },
        labels: ['Πρόταση χρήσης αγγειοσυσταλτικών'],
      }
    }
      // In the same way, update the series option
  },
  mounted() {
    this.getPredictions()
    // this.updateChart()
  },
}
</script>

<style scoped>
h1{
  color: azure;
}
</style>