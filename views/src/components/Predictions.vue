<template>
  <v-container
        color="grey darken-2"
    >

    <apexchart width="500" :options="options" :series="series"></apexchart>
<!--    <apexchart width="500" :options="options" :series="series"></apexchart>
    <apexchart width="500" :options="options" :series="series"></apexchart>
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
    options: {
    },
    series: [],
  }),
  methods: {
    getPredictions() {
      axios
        .get("http://localhost:3000/analysis/" + this.patient.AMKA + "prediction", this.headers)
        .then((response) => (this.response = response));
    },
    updateChart() {
      this.series = [70]
      this.options = {
        series: this.series,
        chart: {
          height: 350,
          type: 'radialBar',
        },
        plotOptions: {
          radialBar: {
            hollow: {
              size: '70%',
            }
          },
        },
        labels: ['Ποσοστό επιβίωσης'],
      }


      // In the same way, update the series option
    }
  },
  mounted() {
    this.updateChart()
  }
}
</script>

<style scoped>

</style>